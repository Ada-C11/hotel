require_relative 'spec_helper'
require_relative '../lib/date_range'

describe DateRange do
  it 'parses date in the correct format %Y-%m-%d' do
    expect(DateRange.valid_date?('2019-05-01')).must_equal true
  end

  it 'rejects invalid date' do
    expect(DateRange.valid_date?('2019-13-01')).must_equal false
  end

  it 'checks for overlaping date ranges' do
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03'], ['2019-05-01', '2019-05-02', '2019-05-03'])).must_equal true
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03'], ['2019-05-02', '2019-05-03', '2019-05-04'])).must_equal true
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03'], ['2019-05-03', '2019-05-04', '2019-05-05'])).must_equal false
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03'], ['2019-04-29', '2019-04-30', '2019-05-01'])).must_equal false
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02'], ['2019-04-30', '2019-05-01', '2019-05-02'])).must_equal true
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02'], ['2019-05-01', '2019-05-02', '2019-05-03'])).must_equal true
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03', '2019-05-04'], ['2019-05-02', '2019-05-03'])).must_equal true
    expect(DateRange.dates_overlap?(['2019-05-01', '2019-05-02', '2019-05-03'], ['2019-05-02', '2019-05-03'])).must_equal true
  end
end