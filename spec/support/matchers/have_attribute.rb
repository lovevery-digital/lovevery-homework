# Have attribute

RSpec::Matchers.define :have_attribute do |expected, type = nil|
  match do |actual|
    if type.present? && actual.class.respond_to?(:columns_hash)
      actual.class.columns_hash.keys.map(&:to_s).include?(expected.to_s) &&
        actual.class.columns_hash[expected.to_s].type == type
    else
      actual.attributes.keys.map(&:to_s).include?(expected.to_s)
    end
  end

  failure_message do |actual|
    "expected that #{actual} would have an attribute called #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not have an attribute called #{expected}"
  end
end
