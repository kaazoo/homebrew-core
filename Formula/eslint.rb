require "language/node"

class Eslint < Formula
  desc "AST-based pattern checker for JavaScript"
  homepage "https://eslint.org"
  url "https://registry.npmjs.org/eslint/-/eslint-5.14.0.tgz"
  sha256 "584e21a73747d22c40bea6612e9d3a8e056d922e646dd6d8fb0e5bdf4becf946"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c0b562f479660cf7e4953cc9a9fa9bfc3fe6835c293b182b84966ddc38dcec1" => :mojave
    sha256 "975151eabede3803d5e8ba4d87f9b0dc2c821a0d20e1afd1c997f8a9ab6ecdec" => :high_sierra
    sha256 "ffa34bc4434a755f7669aa4c9b1eb695c59840318b09b3013bc9972f5525c61a" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/".eslintrc.json").write("{}") # minimal config
    (testpath/"syntax-error.js").write("{}}")
    # https://eslint.org/docs/user-guide/command-line-interface#exit-codes
    output = shell_output("#{bin}/eslint syntax-error.js", 1)
    assert_match "Unexpected token }", output
  end
end
