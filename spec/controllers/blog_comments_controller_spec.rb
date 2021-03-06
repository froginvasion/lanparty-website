require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BlogCommentsController do
# describe_access should be updated to allow passing extra params for the request

# This should return the minimal set of attributes required to create a valid
# BlogComment. As you add validations to BlogComment, be sure to
# update the return value of this method accordingly.
	def valid_attributes
		{ :content => "MyText", :blog_post_id => @blog_post.id, :user_id => @user2.id }
	end

	def additional_params
		@additional_params
	end

	redirect_txt = "redirects to the associated blog_post"

	def on_create_success
		response.should redirect_to(@blog_post)
	end

	def on_create_fail
		response.should redirect_to(@blog_post)
	end

	def on_update_success(instance)
		response.should redirect_to(@blog_post)
	end

	def on_destroy_success
		response.should redirect_to(@blog_post)
	end

	def set_owner(user)
		@user2 = user
		@blog_comment = BlogComment.create! valid_attributes
		@additional_params = additional_params.merge({ :id => @blog_comment.id })
	end

	before(:each) do
		@user = FactoryGirl.create(:user)
		@blog_post = FactoryGirl.build(:blog_post)
		@blog_post.user = @user
		@blog_post.save!
		@additional_params = { :blog_post_id => @blog_post.id }
	end

	describe_access(
		:login => [:edit, :destroy, :update, :create]
	) do

		it_should_require_user_or_access_for_actions(:blog_editing,[:edit,:update,:destroy]) do

			include_examples "standard_controller",
			                 BlogComment,
			                 :only => [:edit, :create, :update, :destroy],
			                 :create => { :on_success => redirect_txt, :on_fail => redirect_txt },
			                 :update => { :on_success => redirect_txt },
			                 :destroy => { :on_success => redirect_txt }

		end
	end
end
