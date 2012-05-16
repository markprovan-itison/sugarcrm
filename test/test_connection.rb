require 'helper'

class TestConnection < ActiveSupport::TestCase
  context "A SugarCRM::Connection instance" do
    should "retrieve the list of available modules" do
      assert_instance_of Array, SugarCRM.modules
      assert_instance_of SugarCRM::Module, SugarCRM.modules[0]
    end
    should "create sub-classes by module name" do
      assert SugarCRM.session.namespace_const.const_defined? "User"
    end
    should "connect with basic auth" do
      #connection = SugarCRM::Connection.new("http://localhost", "user", "pw", {:basic_auth =>{:user => 'basic_auth_user', :pw => 'basic_auth_pw'}})
      SugarCRM.session.disconnect
      SugarCRM::Session.from_file(CONFIG_PATH, {:basic_auth =>{:user => 'basic_auth_user', :pw => 'basic_auth_pw'}})
      SugarCRM.connection.connect!
      assert_equal SugarCRM.connection.request.basic_auth[:user], 'basic_auth_user'
      assert_equal SugarCRM.connection.request.basic_auth[:pw], 'basic_auth_pw'
    end

  end
end