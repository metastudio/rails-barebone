# frozen_string_literal: true

# rubocop:disable Lint/PercentStringArray
SecureHeaders::Configuration.default do |config|
  config.referrer_policy = %w[origin-when-cross-origin strict-origin-when-cross-origin]
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  config.csp = {
    # "meta" values. these will shape the header, but the values are not included in the header.
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    # default: false. If false, `unsafe-inline` will be added automatically when using nonces.
    # If true, it won't. See #403 for why you'd want this.
    disable_nonce_backwards_compatibility: true,

    # directive values: these values will directly translate into source directives
    default_src: %w['self' https:],
    base_uri: %w['self'],
    block_all_mixed_content: true, # see https://www.w3.org/TR/mixed-content/
    font_src: %w['self' https: data:],
    form_action: %w['self'],
    img_src: %w['self' https: data:],
    script_src: %w['self' localhost: https: 'unsafe-inline'],
    style_src: %w['self' localhost: https: 'unsafe-inline'],
    upgrade_insecure_requests: true # see https://www.w3.org/TR/upgrade-insecure-requests/
  }
end
# rubocop:enable Lint/PercentStringArray
