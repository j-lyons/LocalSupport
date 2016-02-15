require_relative '../models/csv_organisation'

class CreateOrganisationFromArray

  def self.create(organisation_repository, row, validate)
    new(organisation_repository, row).create(validate)
  end

  def initialize(organisation_repository, row)
    @organisation_repository = organisation_repository
    @row = row
    @csv_organisation = CSVOrganisation.new(row)
  end

  def create(validate)
    return nil if @csv_organisation.is_organisation_removed? 
    return nil if organisation_already_exists?
    @organisation_repository.create_and_validate(
      name:@csv_organisation.organisation_name,
      address: @csv_organisation.capitalize_address,
      description: @csv_organisation.description.nil? ? '' : @csv_organisation.description.nil?,
      postcode: @csv_organisation.postcode,
      website: @csv_organisation.website ,
      telephone: @csv_organisation.telephone)
  end

  private
  def organisation_already_exists?
    @organisation_repository.find_by_name(@csv_organisation.organisation_name) != nil
  end
end
