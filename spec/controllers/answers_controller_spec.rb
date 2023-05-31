
require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:answer) { create(:answer, question: question, user: user) }
  describe 'POST #create' do
    before { login(user)}
    context 'with valid attributes' do
      let(:new_answer) { post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js }
      it 'saves a new answer in the database' do
        expect{ new_answer }.to change(question.answers, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end

      context 'with invalid attributes' do
        let!(:new_answer) { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question },format: :js }
        it 'does not save the answer' do
          expect{ new_answer }.to_not change(question.answers, :count)
        end
      end
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new, params: { question_id: question } }

    it 'renders new view' do
      expect(response).to render_template 'questions/show'
    end
  end


  describe 'DELETE #destroy' do

    let!(:answer) { create(:answer, question: question, user: user )}

    context 'The author can delete his question or answer' do
      before { login(user) }
      it 'answer was deleted' do
        delete :destroy, params: {id: answer}
        expect(assigns(:answer)).to be_destroyed
      end

      it 'redirects to questions list' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'User is not author' do
      let(:another_user) { create(:user) }
      before { login(another_user) }

      it 'tries to delete answer' do
        expect { delete :destroy, params: { id: answer} }.to_not change(Answer, :count)
      end

      it 'redirects to questions list' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'Unauthorised user' do
      it 'tries to delete answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to login page' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:answer) { create(:answer, question: question) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        put :update, params: { id: answer.id, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end
      # аутентификация
      it 'renders update view' do
        patch :update, params: { id: answer.id, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer.id, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end
end