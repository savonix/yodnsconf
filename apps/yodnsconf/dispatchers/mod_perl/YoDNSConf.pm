package yodnsconf::apps::yodnsconf::dispatchers::mod_perl::YoDNSConf;
use Apache2::Aortica::Aortica ();
use strict;
use Data::Dumper;
use DateTime;


my $tree     = Apache2::Directive::conftree();
my $app_node = $tree->lookup('Location', '/yodnsconf');
my $srv_cfg  = $app_node->{ AorticaServerConfigFile };
my $app_cfg  = $app_node->{ AppConfigFile };

our $doc;




# Create config
my $config = Apache2::Aortica::Kernel::Config->instance();
$config->configure($srv_cfg, $app_cfg, 'yodnsconf');

# Create fence
my $fence_file = $config->{ CONFIG }->{ yodnsconf }->{build}->{sitemap};
my $fence = Apache2::Aortica::Kernel::Fence->instance();
$fence->set_fence($fence_file, 'yodnsconf');

Apache2::Aortica::Kernel::Init->instance('yodnsconf');


sub handler {

    #$| = 1;
    my $r = shift;
    my $output;
    
    # This is necessary so that new request objects aren't created, see:
    # http://perl.apache.org/docs/2.0/user/config/config.html#C_GlobalRequest_
    Apache2::RequestUtil->request($r);
    my $req = Apache2::Request->new($r);
    my $nid = $req->param('nid');
    my $duration = undef;
    my $output = undef;
    my $gate_content_type = undef;

    # Create Gatekeeper
    my $init = Apache2::Aortica::Kernel::Init->instance();


    $init->start();
    my $dbh = Apache2::Aortica::Modules::DataSources::DBIDataSource->instance();
    $output = $init->process_gate($nid);


    $duration = $init->stop();
    $duration = sprintf("%.3f", $duration);
    {
        if ( $gate_content_type = $init->{ yodnsconf }->{ GATE }->{ $nid }->{ CONTENT_TYPE } ) {
            # Memory leak???
            #unless($gate_content_type eq 'text/html') {
            $r->content_type($gate_content_type);
            #}
        }
    }

    if( $req->param('view_flow') eq "true") {
        # Maybe create flow dom document, but populate it and flush it for each request
        my $flow = Apache2::Aortica::Kernel::Flow->instance();
        $doc  = $flow->{ DOC };
        $output .= '<textarea rows="20" style="width: 100%">'.$flow->{ DOC }->toString.'</textarea>';
    }
    my $mem = GTop->new->proc_mem($$)->share/1024;
    my $proc_mem = GTop->new->proc_mem($$)->size/1024;
    my $diff     = $proc_mem - $mem;
    my $shared   = GTop->new->proc_mem($$)->vsize/1024;

    my $memory = " Shared: ".$mem." Total: ".$proc_mem." PID: ".$$ ;


















    unless ( $gate_content_type eq "text/xml") {
        $output .= $duration.$memory;
    }
    my $length = length($output);
    $r->set_content_length($length);
    my $mtime = time();
    $r->set_last_modified($mtime);
    $r->print($output);
    return Apache2::Const::OK;
}

1;
