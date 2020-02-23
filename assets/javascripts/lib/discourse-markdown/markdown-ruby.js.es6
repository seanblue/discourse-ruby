export function setup(helper) {
  helper.registerOptions((opts, siteSettings) => {
    opts.features["markdown-ruby"] = !!siteSettings.enable_markdown_ruby;
  });

  helper.registerPlugin(window.markdownitRuby);
}
