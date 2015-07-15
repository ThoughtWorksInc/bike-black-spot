require 'rspec'

username = 'iamtheonewhotests'
password = 'password!'

describe 'Admin' do

  describe 'username' do
    it 'cannot be blank' do
      admin = Admin.new(username: '')
      admin.valid?

      expect(admin.errors[:username]).to include("can't be blank")
    end

    it 'can be only blank spaces' do
      admin = Admin.new(username: '   ')
      admin.valid?

      expect(admin.errors[:username]).to include("can't be blank")
    end

    it 'should be more then 3 characters' do
      admin = Admin.new(username: 'a')
      admin.valid?

      expect(admin.errors[:username]).to include("is too short (minimum is 3 characters)")
    end

    it 'should be less then 20 characters' do
      admin = Admin.new(username: '1234567891011121314151617181920')
      admin.valid?

      expect(admin.errors[:username]).to include("is too long (maximum is 20 characters)")
    end

    it 'should is allowed to be 20 characters' do
      admin = Admin.new(username: '12345678901234567890')
      admin.valid?

      expect(admin.errors[:username]).to_not include("is too long (maximum is 20 characters)")
    end
  end
  describe 'create' do
    it 'should fail when just a username is used' do
      begin
        Admin.create(username: username)
      rescue Exception => e
        expect(e.to_s).to include('ERROR:  null value in column "encrypted_password"')
      end
    end

    it 'should fail when just a password is used' do
      begin
        Admin.create(password: password)
      rescue Exception => e
        expect(e.to_s).to include('ERROR:  null value in column "username"')
      end
    end

    it 'should make an admin when passed in a username and password' do
      admin = Admin.create(username: username, password: password)
      found_admin = Admin.where(:username => username)

      expect(found_admin).to_not be_nil
      admin.delete
    end
    it 'should make an admin when passed in a username with space in it' do
      admin = Admin.create(username: username+' '+username, password: password)
      found_admin = Admin.where(:username => username)

      expect(found_admin).to_not be_nil
      admin.delete
    end

    it 'should not make an admin when duplicate usernames are used' do
      admin1 = Admin.create(username: username, password: password)
      Admin.create(username: username, password: password)

      found_admins = Admin.where(username: username)

      expect(found_admins.length).to be(1)
      admin1.delete
    end
  end
  describe 'Authentication' do
    it 'should not authenticate the incorrect password' do
      admin = Admin.create(username: username, password: password)

      expect(admin.authenticate('fail')).to be(false)
      admin.delete
    end

    it 'should authenticate the correct password' do
      admin = Admin.create(username: username, password: password)

      expect(admin.authenticate(password)).to be(true)
      admin.delete
    end
  end
end