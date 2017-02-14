require 'spec_helper'

describe Admin::CommentsController, type: :controller do

  # It is necessary to use bang version of let to build roles before user
  let(:conference) { create(:conference) }
  let!(:organizer_role) { Role.find_by(name: 'organizer', resource: conference) }
  let(:organizer) { create(:user, role_ids: organizer_role.id, last_sign_in_at: Time.now - 1.day,name: "sid") }
  let(:participant) { create(:user,name: "sid1") }
  let(:event) { create(:event, program: conference.program) }
  let(:comment) { create(:comment, commentable_type: 'Event', commentable_id: event.id) }

  context 'not logged in user' do

    describe 'GET #index' do
        puts  "before test",User.all.count
      it 'renders the :index template' do
        puts  User.all.count,"1a"
        #comment
        get :index
        expect(response).to redirect_to(user_session_path)
        puts  User.all.count,"1b"
      end
    end
  end

  context 'logged in as admin, organizer or cfp' do
    before :each do
      #sign_in(organizer)
      #comment
    end
    describe 'GET #index' do
      puts  "before test",User.all.count
      it 'populates a hash with comments' do
        puts  User.all.count,"2a"
        get :index
        expect(assigns(:comments)).to be_a(Hash)
        # assigns(:comments).first returns an array of first pair key-value from hash.
        # Calling again 'first' returns the key, meaning the Conference object.
        expect(assigns(:comments).first.first.title).to eq(comment.commentable.program.conference.title)
        puts  User.all.count,"2b"
      end
      it 'has status 200: OK' do
        puts  User.all.count,"3a"
        get :index
        expect(response).to have_http_status(:ok)
        puts  User.all.count,"3b"
      end
      it 'renders the :index template' do
        puts  User.all.count,"4a"
        get :index
        expect(response).to render_template(:index)
        puts  User.all.count,"4b"
      end
    end
  end

  context 'logged in with any other role or normal user' do
    describe 'GET#index' do
      it 'requires organizer privileges' do
        puts  User.all.count,"5a"
        #sign_in(participant)
        #comment
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match('You are not authorized to access this area!')
        puts  User.all.count,"5a"
      end
    end
  end
  puts  User.all.count,"second"
end
