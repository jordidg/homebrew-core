class Jql < Formula
  desc "JSON query language CLI tool"
  homepage "https://github.com/yamafaktory/jql"
  url "https://github.com/yamafaktory/jql/archive/refs/tags/jql-v7.1.13.tar.gz"
  sha256 "eb558535914ea28ab39761c0a38f22e46e6a24c2f82d2a930cf003e413c7458d"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/yamafaktory/jql.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ac5225a7f321beb69ca5f5bb2160ad8ca6c0aff1a6af119d1f9ef7c42f9267fc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "643f7e03c981fef027328732473706806124941bce28948a7c91b8feb8cbde19"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5df2d047f67d587ad705c60ec05d83ee810f31107bd38fcb0d820158e1e1f36f"
    sha256 cellar: :any_skip_relocation, sonoma:         "a5290129a7dee8ce47dd903f0a9717d133253349350b3f1de622485842c0a6b7"
    sha256 cellar: :any_skip_relocation, ventura:        "524707ed27763cf92915de1a220b1b92c274455da3d4cfbec001b4e502f0f726"
    sha256 cellar: :any_skip_relocation, monterey:       "5f8d02da9aa962ab0962d34b7c26f87fe7b3b0806f4ece95d5a436065e8bb6c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4cbc1f8c7f3ebd129601589b9179c82e6e85e28f02bd8c4d89ff0405134143f8"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/jql")
  end

  test do
    (testpath/"example.json").write <<~EOS
      {
        "cats": [{ "first": "Pixie" }, { "second": "Kitkat" }, { "third": "Misty" }]
      }
    EOS
    output = shell_output("#{bin}/jql --inline --raw-string '\"cats\" [2:1] [0]' example.json")
    assert_equal '{"third":"Misty"}', output.chomp
  end
end
