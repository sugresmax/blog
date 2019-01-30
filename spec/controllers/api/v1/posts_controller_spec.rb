require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'GET #index' do

    posts_count = rand(10..15)
    per_page = rand(3..5)
    total_pages = (posts_count / per_page.to_f).ceil
    current_page = rand(1..total_pages)

    let!(:posts){ posts_count.times.map{ create(:post) } }

    before do
      process :index, method: :get, params: { page: current_page, per_page: per_page, format: :json }
    end

    it 'returns success status' do
      expect(response).to have_http_status(:success)
    end

    it 'has posts_count in heasers' do
      expect(response.headers['posts_count']).to eq posts_count
    end

    it 'has total_pages in heasers' do
      expect(response.headers['total_pages']).to eq total_pages
    end

    it 'returns posts count less or equal per_page param' do
      result = JSON.parse(response.body)
      expect(result.length).to be <= per_page
    end

    it 'renders posts as json' do
      result = JSON.parse(response.body)
      expect(result[0]).to have_key('id')
      expect(result[0]).to have_key('title')
      expect(result[0]).to have_key('body')
      expect(result[0]).to have_key('published_at')
      expect(result[0]).to have_key('author_nickname')
    end

  end

  describe 'GET #show' do

    let!(:post){ create(:post) }

    before do
      process :show, method: :get, params: { id: post.id, format: :json }
    end

    it 'returns success status' do
      expect(response).to have_http_status(:success)
    end

    it 'render post as json' do
      result = JSON.parse(response.body)
      expect(result).to have_key('id')
      expect(result).to have_key('title')
      expect(result).to have_key('body')
      expect(result).to have_key('published_at')
      expect(result).to have_key('author_nickname')
    end

  end

  describe 'POST #create' do

    let!(:user){ create(:user) }
    let!(:post){ build(:post) }

    context 'when user authorized' do

      before do
        process :create, method: :post, session: { user_id: user.id },
                params: { post: post.as_json, format: :json }
      end

      it 'returns post as json' do
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('title')
        expect(result).to have_key('body')
        expect(result).to have_key('published_at')
        expect(result).to have_key('author_nickname')
      end

      it 'returns post equal sent' do
        result = JSON.parse(response.body)
        expect(result['title']).to eq(post.title)
        expect(result['body']).to eq(post.body)
        expect(Time.parse(result['published_at']).to_i).to eq(post.published_at.to_i)
        expect(result['author_nickname']).to eq(user.nickname)
      end

    end

    context 'when user not authorized' do

      it 'returns not authorized status' do
        process :create, method: :post, params: { post: post.as_json, format: :json }
        expect(response.status).to eq 401
      end

    end

  end

end