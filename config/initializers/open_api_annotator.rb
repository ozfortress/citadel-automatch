if defined? OpenApiAnnotator
  OpenApiAnnotator.configure do |config|
    config.info = OpenApi::Info.new(title: 'Citadel AutoMatch', version: '1')
    config.destination_path = Rails.root.join('docs', 'api_spec.yml')
    config.path_regexp = /\Aapi\/v1\/automatch\// # If you want to restrict a path to create
  end
end
