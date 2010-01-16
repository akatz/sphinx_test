require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Posts.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Posts.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Posts.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to posts_url(assigns(:posts))
  end
  
  def test_edit
    get :edit, :id => Posts.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Posts.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Posts.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Posts.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Posts.first
    assert_redirected_to posts_url(assigns(:posts))
  end
  
  def test_destroy
    posts = Posts.first
    delete :destroy, :id => posts
    assert_redirected_to posts_url
    assert !Posts.exists?(posts.id)
  end
end
