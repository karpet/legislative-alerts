class Alert::Search < Alert
  OS_FIELDS = 'bill_id,state,session,title,actions'.freeze

  def self.model_name
    Alert.model_name
  end

  def check
    if results_have_changed?(query)
      return update_as_run(os_checksum(recent_actions))
    end
  end

  def url_name
    'search/'
  end

  def os_bill
    false
  end

  def os_ts_query
    parsed_query.merge(q: ts_query)
  end

  def ts_query
    q = parsed_query[:q]
    return q if q =~ /&\|/
    tokens = q.split
    tokens.join(' & ')
  end

  def os_results
    @_os_results ||= OpenStates::Bill.where(os_ts_query.merge(per_page: 10, fields: OS_FIELDS))
  end

  def url_query
    '?' + parsed_query.to_query(:search)
  end

  def recent_actions
    os_results.select { |bill| bill.actions.any? }.map do |bill|
      bill.actions.last.slice('action', 'date')
    end
  end

  private

  def results_have_changed?(_query)
    checksum != os_checksum(recent_actions)
  end
end
