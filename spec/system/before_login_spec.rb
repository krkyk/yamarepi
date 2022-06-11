require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '新規登録リンクが表示される' do
        find_all('a')[6].native.inner_text
      end
      it '新規登録リンクの内容が正しい' do
        sign_up_link = find_all('a')[6].native.inner_text
        expect(page).to have_link sign_up_link, href: new_customer_registration_path
      end
      it 'ログインリンクが表示される' do
        find_all('a')[7].native.inner_text
      end
      it 'ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[7].native.inner_text
        expect(page).to have_link log_in_link, href: new_customer_session_path
      end
    end
  end

  describe 'About画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ロゴリンクが表示される' do
        find_all('a')[0].find('img')
      end
      it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/About/)
      end
      it 'レシピ一覧リンクが表示される: 左上から3番目のリンクが「レシピ一覧」である' do
        index_link = find_all('a')[2].native.inner_text
        expect(index_link).to match(/レシピ一覧/)
      end
      it '新規登録リンクが表示される: 左上から4番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[3].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it 'ログインリンクが表示される: 左上から5番目のリンクが「ログイン」である' do
        login_link = find_all('a')[4].native.inner_text
        expect(login_link).to match(/ログイン/)
      end
      it 'ゲストログインリンクが表示される: 左上から5番目のリンクが「ゲストログイン(閲覧用)」である' do
        guest_login_link = find_all('a')[5].native.inner_text
        expect(guest_login_link).to match(" ゲストログイン(閲覧用)")
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'ロゴを押すと、トップ画面に遷移する' do
        find_all('a')[0].click
        is_expected.to eq '/'
      end
      it 'Aboutを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'レシピ一覧を押すと、レシピ一覧画面に遷移する' do
        recipes_link = find_all('a')[2].native.inner_text
        recipes_link = recipes_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link recipes_link
        is_expected.to eq '/recipes'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[3].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/customers/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/customers/sign_in'
      end
      it 'ゲストログインを押すと、トップ画面に遷移する' do
        guest_login_link = find_all('a')[5].native.inner_text
        guest_login_link = guest_login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link guest_login_link, match: :first
        is_expected.to eq '/'
      end
    end
  end

  describe '会員新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'customer[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規会員登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、トップ画面になっている' do
        click_button '新規会員登録'
        expect(current_path).to eq '/'
      end
    end
  end

  describe '会員ログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'customer[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップ画面になっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'ロゴが表示される: 左上から1番目のリンクが「ロゴ」である' do
        find_all('a')[0].native.inner_text
      end
      it 'マイページリンクが表示される: 左上から2番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[1].native.inner_text
        expect(mypage_link).to match(/マイページ/)
      end
      it 'レシピ一覧リンクが表示される: 左上から3番目のリンクが「レシピ一覧」である' do
        recipes_link = find_all('a')[2].native.inner_text
        expect(recipes_link).to match(/レシピ一覧/)
      end
      it 'レシピ作成リンクが表示される: 左上から4番目のリンクが「レシピ作成」である' do
        new_recipe_link = find_all('a')[3].native.inner_text
        expect(new_recipe_link).to match(/レシピ作成/)
      end
      it '掲示板リンクが表示される: 左上から5番目のリンクが「掲示板」である' do
        forums_link = find_all('a')[4].native.inner_text
        expect(forums_link).to match(/掲示板/)
      end
      it 'ログアウトリンクが表示される: 左上から6番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      logout_link = find_all('a')[5].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end