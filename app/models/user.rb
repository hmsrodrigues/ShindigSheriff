class RolesValidator < ActiveModel::Validator
  def validate(record)
    case record.role_name
    when "organizer"
      #record.errors[:organization] << "can't be blank" if record.organizations.empty?
    when "finance approver"
      unless record.organizations.empty?
        record.errors[:finance_approver] << "does not need to register an organization"
      end
    else
      record.errors[:role] << "cannot be empty, please select a role"
    end
  end
end
  
class User < ActiveRecord::Base
  include ActiveModel::Validations

  before_save { validates_with RolesValidator }
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  has_many :events, through: :organizations
  has_many :incomes, through: :events

  has_many :organizations
  accepts_nested_attributes_for :organizations

  has_one :organizations_as_role, class_name: 'FinanceApprover',
          foreign_key: 'finance_approver_id'

  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :roles

  def info
    "#{first_name.capitalize} #{last_name.capitalize} : #{email}"
  end

  def has_role? name
    roles.pluck(:name).include?(name)
  end
  
  def role= name
    role = Role.find_by_name(name)
    self.roles << role if role
  end

  def role_name
    roles.map(&:name).first
  end

end