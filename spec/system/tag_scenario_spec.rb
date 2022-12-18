require 'rails_helper'

RSpec.describe 'タグ関連の機能', type: :system do
  let!(:user) { create(:user) }

  describe '新規作成' do
    before do
      visit "login_as/#{user.id}"
    end

    it 'タグが保存されること' do
      visit '/posts/new'
      fill_in 'タイトル', with: 'Webエンジニアに俺はなる'
      fill_in '内容', with: '卒業試験簡単過ぎるわ!!'
      fill_in 'タグ', with: 'Ruby'
      click_button '登録する'
      expect(page).to have_content('Ruby')
    end

    it 'タグが複数保存されること' do
      visit '/posts/new'
      fill_in 'タイトル', with: 'Webエンジニアに俺はなる'
      fill_in '内容', with: '卒業試験簡単過ぎるわ!!'
      fill_in 'タグ', with: 'Ruby,Rails,ActiveRecord'
      click_button '登録する'
      expect(page).to have_content('Ruby')
      expect(page).to have_content('Rails')
      expect(page).to have_content('ActiveRecord')
    end

    it '同じタグを入力しても重複してレコードが生成されないこと' do
      visit '/posts/new'
      fill_in 'タイトル', with: 'Webエンジニアに俺はなる'
      fill_in '内容', with: '卒業試験簡単過ぎるわ!!'
      fill_in 'タグ', with: 'Ruby,Rails,ActiveRecord'
      click_button '登録する'

      visit '/posts/new'
      fill_in 'タイトル', with: 'Webエンジニアに俺はなる'
      fill_in '内容', with: '卒業試験簡単過ぎるわ!!'
      fill_in 'タグ', with: 'Ruby,Rails,ActiveRecord'
      expect { click_button '登録する' }.not_to change { Tag.count }
    end
  end

  describe '編集' do
    before do
      visit "login_as/#{user.id}"
    end

    it 'タグの編集ができること' do
      visit '/posts/new'
      fill_in 'タイトル', with: 'Webエンジニアに俺はなる'
      fill_in '内容', with: '卒業試験簡単過ぎるわ!!'
      fill_in 'タグ', with: 'Ruby,Rails,ActiveRecord'
      click_button '登録する'
      click_link '編集'
      expect(page).to have_selector("input[value='Ruby,Rails,ActiveRecord']")
      fill_in 'タグ', with: 'Ruby,Web,Gem'
      click_button '更新する'
      expect(page).to have_content('Ruby')
      expect(page).to have_content('Web')
      expect(page).to have_content('Gem')
    end
  end
end
