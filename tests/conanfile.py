from atsconan import ATSConan

class ATSConan(ATSConan):
    name = "ats-result-tests"
    version = "0.1.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "atsmake"
    exports_sources = "*"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    requires = "ats-result/0.1.1@randy.valis/testing"
    build_requires = "ats-unit-testing/0.1@randy.valis/testing"

    def package(self):
        self.copy("tests", dst="target", keep_path=False)

    def deploy(self):
        self.copy("*", src="target", dst="bin")
