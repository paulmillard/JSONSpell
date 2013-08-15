use strict;
use warnings;

use JSONSpell;

my $app = JSONSpell->apply_default_middlewares(JSONSpell->psgi_app);
$app;

