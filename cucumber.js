const common = [
  'features/**/*.feature',
  '--require-module ts-node/register',
  '--require features/common/**/*.steps.ts',
  '--require features/route/**/*.steps.ts',
  `--require features/${process.env.PROVIDER_NAME}/**/*.steps.ts`,
  '--format progress-bar',
  '--format @cucumber/pretty-formatter',
  '--publish-quiet'
].join(' ');

module.exports = {
  default: common
};
