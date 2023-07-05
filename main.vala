using Package;

void main() {
    Package.Package package = new Package.Package();
    var pkg = package.getArchPackage("pacman");
    stdout.printf("package name = %s",pkg);
}
