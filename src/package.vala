namespace Package
{
    public class Package {
        public string getArchPackage(string p_name) {
            var pkgname = "";
            var uri = "https://archlinux.org/packages/search/json/?q=%s".printf (p_name);
            var session = new Soup.Session ();
            var message = new Soup.Message ("GET", uri);
            session.send_message (message);
            try {

            var parser = new Json.Parser();

            parser.load_from_data((string)message.response_body.flatten().data,-1);

            var root_object = parser.get_root().get_object();
            var results = root_object.get_array_member("results");

            int64 count = results.get_length();

            foreach(var pnodes in results.get_elements()) {
                var pnode = pnodes.get_object();
                pkgname = pnode.get_string_member("pkgname");
                var depends = pnode.get_array_member("depends");
                foreach (var depend in depends.get_elements())
                {
                    var value = depend.get_value();
                    stdout.printf("%s\n",(string)value);
                }
            }
            
            return pkgname;
        }
        catch(Error e) {
            stderr.printf ("I guess something is not working...\n");
            return (string)e;
        }
        }
    }
}