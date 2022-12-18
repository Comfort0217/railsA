require 'rails_helper'

RSpec.describe '検索関連の機能', type: :system do
  describe '投稿フィールドに対する検索機能' do
    let!(:post_a) { create(:post, title: 'どうやったらエンジニアになれますか', body: '効率の良い勉強方法を教えてください') }
    let!(:post_b) { create(:post, title: 'Rails簡単過ぎて草', body: 'MVCに沿ってつくればオールオッケー') }

    describe 'titleでの検索' do
      it 'titleで検索ができること' do
        # titleでの検索
        visit '/posts'
        fill_in 'search_field_of_post', with: 'エンジニア'
        click_on 'Search'
        expect(page).to have_content post_a.title
        expect(page).not_to have_content post_b.title
      end
    end

    describe 'bodyでの検索' do
      it 'bodyで検索ができること' do
        visit '/posts'
        fill_in 'search_field_of_post', with: 'MVC'
        click_on 'Search'
        expect(page).not_to have_content post_a.title
        expect(page).to have_content post_b.title
      end
    end
  end

  describe 'コメントフィールドに対する検索機能' do
    let!(:post_a) do
      post = create(:post, title: 'どうやったらエンジニアになれますか', body: '効率の良い勉強方法を教えてください')
      create(:comment, body: '基礎を疎かにしないことです。遠回りに見えて一番効率が良いです。', post: post)
      post
    end
    let!(:post_b) do
      post = create(:post, title: 'Rails簡単過ぎて草', body: 'MVCに沿ってつくればオールオッケー')
      create(:comment, body: '実務ではレールから外れることが多いのでそんな簡単にいきませんよ', post: post)
      post
    end
    it 'bodyで検索ができること' do
      visit '/posts'
      fill_in 'search_field_of_comment', with: '効率'
      click_on 'Search'
      expect(page).to have_content post_a.title
      expect(page).not_to have_content post_b.title
    end
  end

  describe 'ユーザーフィールドに対する検索機能' do
    let!(:post_a) do
      user = create(:user)
      user.profile.update(name: 'らんてくん')
      post = create(:post, title: 'どうやったらエンジニアになれますか', body: '効率の良い勉強方法を教えてください', user: user)
      post
    end
    let!(:post_b) do
      user = create(:user)
      user.profile.update(name: 'らんてちゃん')
      post = create(:post, title: 'Rails簡単過ぎて草', body: 'MVCに沿ってつくればOK', user: user)
      post
    end
    it 'nameで検索ができること' do
      visit '/posts'
      fill_in 'search_field_of_user', with: 'らんてくん'
      click_on 'Search'
      expect(page).to have_content post_a.title
      expect(page).not_to have_content post_b.title
    end
  end

  describe '投稿, コメント, ユーザーの複合検索' do
    let!(:post_a) do
      user = create(:user)
      user.profile.update(name: 'らんてくん')
      post = create(:post, title: 'どうやったらエンジニアになれますか', body: '効率の良い勉強方法を教えてください', user: user)
      create(:comment, body: '基礎を疎かにしないことです。遠回りに見えて一番効率が良いです。', post: post)
      post
    end
    let!(:post_b) do
      user = create(:user)
      user.profile.update(name: 'らんてちゃん')
      post = create(:post, title: 'Rails簡単過ぎて草', body: 'MVCに沿ってつくればOK', user: user)
      create(:comment, body: '実務ではレールから外れることが多いのでそんな簡単にいきませんよ', post: post)
      post
    end
  end

  describe 'タグでの絞り込み' do
    let!(:post_a) do
      post = create(:post)
      post.tags << create(:tag, name: 'tag_a')
      post
    end

    let!(:post_b) do
      post = create(:post)
      post.tags << create(:tag, name: 'tag_b')
      post
    end

    it 'タグで絞り込みができること' do
      visit '/posts'
      click_link 'tag_a'

      expect(page).to have_content post_a.title
      expect(page).not_to have_content post_b.title
    end
  end
end
