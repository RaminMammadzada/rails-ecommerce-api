class ApiVersion
  attr_reader :version, :default

  def initialize(version, default)
    @version = version
    default = false if default.nil?
    @default = default
  end

  # check whether version is specified or is default
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  def check_headers(headers)
    # check version from Accept headers; expect custom media type `categories`
    accept = headers[:accept]
    accept&.include?("application/vnd.categories.#{version}+json")
  end
end
