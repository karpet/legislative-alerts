FactoryBot.define do
  factory :alert do
    factory :search_alert, class: Alert::Search do
      alert_type { Alert::Search.name }
    end
  end
end
