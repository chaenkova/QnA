require 'rails_helper'

shared_examples_for 'voted' do
  before { @params = { id: resource, format: :json } }

  describe 'PUT #vote_plus' do
    context 'Authenticated user not author' do
      before { login(user) }

      it 'saves a new vote in db' do
        expect do
          put :vote_plus, params: @params
        end.to change(Vote, :count).by(1)
      end

      it 'assigns votable' do
        put :vote_plus, params: @params
        expect(assigns(:votable)).to eq(resource)
      end

      it 'vote plus' do
        put :vote_plus, params: @params
        expect(resource.total_rating).to eq(1)
      end

      it 'not vote if vote twice' do
        put :vote_plus, params: @params
        put :vote_plus, params: @params
        expect(resource.votes.last.rating).to eq(1)
      end

      it 'responds to json format' do
        put :vote_plus, params: @params
        expect(response.content_type).to include('json')
      end
    end

    context 'Authenticated user as author' do
      before { login(author) }

      it 'not saves a new vote in db' do
        expect do
          put :vote_plus, params: @params
        end.to_not change(Vote, :count)
      end

      it 'assigns votable' do
        put :vote_plus, params: @params
        expect(assigns(:votable)).to eq(resource)
      end

      it 'responds to json format' do
        put :vote_plus, params: @params
        expect(response.content_type).to include('json')
      end

      it 'render json with errors' do
        put :vote_plus, params: @params
        expect(response.body).to include('unprocessable_entity')
        expect(response.body).to include('error')
      end
    end

    context 'Unauthenticated user' do
      it 'not saves a new vote in db' do
        expect do
          put :vote_plus, params: @params
        end.to_not change(Vote, :count)
      end

      it 'assigns votable' do
        put :vote_plus, params: @params
        expect(assigns(:votable)).to eq(resource)
      end

      it 'responds to json format' do
        put :vote_plus, params: @params
        expect(response.content_type).to include('json')
      end

      it 'render json with errors' do
        put :vote_plus, params: @params
        expect(response.status).to eq(401)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'PUT #vote_minus' do
    context 'Authenticated user not author' do
      before { login(user) }

      it 'saves a new vote in db' do
        expect do
          put :vote_minus, params: @params
        end.to change(Vote, :count).by(1)
      end

      it 'assigns votable' do
        put :vote_minus, params: @params
        expect(assigns(:votable)).to eq(resource)
      end

      it 'vote minus' do
        put :vote_minus, params: @params
        expect(resource.votes.last.rating).to eq(-1)
      end

      it 'not vote if voted' do
        put :vote_minus, params: @params
        put :vote_minus, params: @params
        expect(resource.total_rating).to eq(-1)
      end

      it 'responds to json format' do
        put :vote_minus, params: @params
        expect(response.content_type).to include('json')
      end
    end
  end

  context 'Authenticated user as author' do
    before { login(author) }

    it 'not saves a new vote in db' do
      expect do
        put :vote_minus, params: @params
      end.to_not change(Vote, :count)
    end

    it 'assigns votable' do
      put :vote_minus, params: @params
      expect(assigns(:votable)).to eq(resource)
    end

    it 'responds to json format' do
      put :vote_minus, params: @params
      expect(response.content_type).to include('json')
    end

    it 'render json with errors' do
      put :vote_minus, params: @params
      expect(response.body).to include('unprocessable_entity')
      expect(response.body).to include('error')
    end
  end

  context 'Unauthenticated user' do
    it 'not saves a new vote in db' do
      expect do
        put :vote_minus, params: @params
      end.to_not change(Vote, :count)
    end

    it 'assigns votable' do
      put :vote_minus, params: @params
      expect(assigns(:votable)).to eq(resource)
    end

    it 'responds to json format' do
      put :vote_minus, params: @params
      expect(response.content_type).to include('json')
    end

    it 'render json with errors' do
      put :vote_minus, params: @params
      expect(response.status).to eq(401)
      expect(response.body).to include('error')
    end
  end

  describe 'DELETE #cancel' do
    context 'Authenticated user not author' do
      before { login(user) }

      context 'voted before' do
        before { put :vote_plus, params: @params }

        it 'cancel vote from db' do
          expect do
            delete :cancel, params: @params
          end.to change(Vote, :count).by(-1)
        end

        it 'change total rating' do
          delete :cancel, params: @params
          expect(resource.total_rating).to eq(0)
        end

        it 'assigns votable' do
          delete :cancel, params: @params
          expect(assigns(:votable)).to eq(resource)
        end

        it 'responds to json format' do
          delete :cancel, params: @params
          expect(response.content_type).to include('json')
        end
      end

      context 'not voted before' do
        it 'not cancel vote from db' do
          expect do
            delete :cancel, params: @params
          end.to_not change(Vote, :count)
        end

        it 'not change total rating' do
          delete :cancel, params: @params
          expect(resource.total_rating).to eq(0)
        end
      end
    end

    context 'Authenticated user as author' do
      before { login(author) }
      it 'not cancel vote from db' do
        expect do
          delete :cancel, params: @params
        end.to_not change(Vote, :count)
      end

      it 'not change total rating' do
        delete :cancel, params: @params
        expect(resource.total_rating).to eq(0)
      end
    end

    context 'Unauthenticated' do
      it 'not cancel vote from db' do
        expect do
          delete :cancel, params: @params
        end.to_not change(Vote, :count)
      end

      it 'not change total rating' do
        delete :cancel, params: @params
        expect(resource.total_rating).to eq(0)
      end

      it 'responds to json format' do
        delete :cancel, params: @params
        expect(response.content_type).to include('json')
      end

      it 'render json with errors' do
        delete :cancel, params: @params
        expect(response.status).to eq(401)
        expect(response.body).to include('error')
      end
    end
  end
end