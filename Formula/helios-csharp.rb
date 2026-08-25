class HeliosCsharp < Formula
  desc "Roslyn helper for helios: compiler-accurate C# reference resolution"
  homepage "https://github.com/simonspoon/helios"
  version "0.43.0"
  license "MIT"

  # Pure IL, framework-dependent — one platform-neutral bundle for every OS/arch.
  url "https://github.com/simonspoon/helios/releases/download/v0.43.0/helios-roslyn.zip"
  sha256 "177b00eca88f825208890932e64391d09877189da5a29b0262c32d6eea22d635"

  depends_on "helios"

  def install
    # Bundle stays intact in libexec (dotnet needs deps.json, dependency dlls,
    # and the BuildHost-* dirs next to the real dll; brew skips subdirs when
    # linking bin). Only the entry dll is linked into bin, where helios looks
    # for it next to its own binary — the dotnet host resolves the symlink
    # back to libexec before loading dependencies.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"helios-roslyn.dll"
  end

  def caveats
    <<~EOS
      Requires a .NET runtime (8.0 or later) on PATH: dotnet --version
      Projects with a .csproj/.sln additionally need the .NET SDK.
      Without dotnet, helios silently falls back to tree-sitter C# resolution.

      Verify after re-running `helios init` in a C# repo:
        helios status   # → "C# resolver: roslyn"
    EOS
  end

  test do
    assert_path_exists bin/"helios-roslyn.dll"
  end
end
