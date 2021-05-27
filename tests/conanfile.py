from atsconan import ATSConan

class ATSConan(ATSConan):
    name = "ats-result-tests"
    version = "0.1.1"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    requires = "ats-result/0.1.1@randy.valis/testing"
    build_requires = "ats-unit-testing/0.1@randy.valis/testing"

    def package(self):
        self.copy("tests", dst="target", keep_path=False)

    def deploy(self):
        self.copy("*", src="target", dst="bin")
