require 'rails_helper'

RSpec.describe 'サインアップの機能', type: :system do
  describe 'サインアップ' do
    context 'GitHubに存在するnameを入力した場合' do
      it 'ユーザーが一人作成されること' do
        visit '/sign_up'
        fill_in 'ニックネーム', with: 'runteq'
        fill_in 'メールアドレス', with: 'runteq@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on 'サインアップ'
        expect(page).to have_content 'サインアップしました'
        expect(User.count).to eq 1
      end
    end

    context 'GitHubに存在しないnameを入力した場合' do
      it '「GitHubに存在するユーザー名しか登録できません」というエラーメッセージが表示されること' do
        visit '/sign_up'
        fill_in 'ニックネーム', with: 'runteqqqqqqqqqqqqqqqqqqqqqqq'
        fill_in 'メールアドレス', with: 'runteq@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on 'サインアップ'
        expect(page).to have_content 'GitHubに存在するユーザー名しか登録できません'
        expect(User.count).to eq 0
      end
    end
  end
end
