require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  setup do
    @alex = FactoryGirl.create(:owner)
    @rachel = FactoryGirl.create(:owner, first_name: "Rachel", active: false)
    @mark = FactoryGirl.create(:owner, first_name: "Mark", phone: "412-268-8211")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:owners)
    assert_equal %w[Alex Mark], assigns(:owners).map(&:first_name)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a new owner" do
    assert_difference('Owner.count') do
      post :create, owner: { active: @alex.active, city: @alex.city, email: "dusty@example.com", first_name: "Dusty", last_name: @alex.last_name, phone: @alex.phone, state: @alex.state, street: @alex.street, zip: @alex.zip }
    end
    assert_redirected_to owner_path(assigns(:owner))
  end

  test "should show owner and the pets belonging to owner" do
    @cat = FactoryGirl.create(:animal)
    @dusty = FactoryGirl.create(:pet, animal: @cat, owner: @alex, female: false)
    @polo = FactoryGirl.create(:pet, animal: @cat, owner: @alex, name: "Polo", active: false)
    get :show, id: @alex
    assert_not_nil assigns(:owner)
    assert_not_nil assigns(:current_pets)
    assert_equal "Heimann, Alex", assigns(:owner).name
    assert_equal %w[Dusty], assigns(:current_pets).map(&:name)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alex
    assert_not_nil assigns(:owner)
    assert_response :success
  end

  test "should update an owner" do
    patch :update, id: @alex, owner: { active: @alex.active, city: @alex.city, email: @alex.email, first_name: "Alexander", last_name: @alex.last_name, phone: @alex.phone, state: @alex.state, street: @alex.street, zip: @alex.zip }
    assert_redirected_to owner_path(assigns(:owner))
  end

  test "should destroy owner" do
    assert_difference('Owner.count', -1) do
      delete :destroy, id: @alex
    end
    assert_redirected_to owners_path
  end
end

