class Alert::Search < Alert
  OS_FIELDS = 'bill_id,state,session,title,actions'.freeze

  def self.model_name
    Alert.model_name
  end

  def check
    if results_have_changed?(query)
      return update_as_run(os_checksum(os_results))
    end
  end

  def public_url
    "#{Rails.application.routes.url_helpers.root_url}search/#{url_query}"
  end

  def os_results
    @_os_results ||= OpenStates::Bill.where(parsed_query.merge(per_page: 10, fields: OS_FIELDS))
  end

  def url_query
    '?' + parsed_query.to_query(:search)
  end

  private

  def results_have_changed?(_query)
    checksum != os_checksum(os_results)
  end
end
