package Plack;

use strict;
use warnings;
use 5.008_001;
our $VERSION = '0.9913';
$VERSION = eval $VERSION;

1;
__END__

=head1 NAME

Plack - Perl Superglue for Web frameworks and Web Servers (PSGI toolkit)

=head1 DESCRIPTION

Plack is a set of tools for using PSGI stack. It contains middleware
components, a reference server and utilities for Web application
frameworks. Plack is like Ruby's Rack or Python's Paste for WSGI.

See L<PSGI> for the PSGI specification and L<PSGI::FAQ> to know what
PSGI and Plack are and why we need them.

=head1 MODULES AND UTILITIES

=head2 Plack::Handler

L<Plack::Handler> and its subclasses contains adapters for web
servers. We have adapters for Standalone, CGI, FCGI, Apache, AnyEvent,
Coro, Danga::Socket and many server environments that you can run PSGI
applications on.

See L<Plack::Handler> how to write your own adapters.

=head2 Plack::Loader

L<Plack::Loader> is a loader to load one of Plack::Server adapters and
run PSGI application code reference with it.

=head2 Plack::Util

L<Plack::Util> contains a lot of utility functions for server
implementors as well as middleware authors.

=head2 .psgi files

PSGI application is a code reference but it's not easy to pass code
reference in the command line or configuration files, so Plack uses a
convention that you need a file named C<app.psgi> or alike, which
would be loaded (via perl's core function C<do>) to return the PSGI
application code reference.

  # Hello.psgi
  my $app = sub {
      my $env = shift;
      # ...
      return [ $status, $headers, $body ];
  };

If you use a web framework, chances are that they provide a helper
utility to automatically generate these C<.psgi> files for you, such
as:

  # MyApp.psgi
  use MyApp;
  my $app = sub { MyApp->run_psgi(@_) };

It's important that the return value of C<.psgi> file is the code
reference. See eg/dot-psgi directory for more examples of C<.psgi>
files.

=head2 plackup, Plack::Runner

L<plackup> is a command line launcher to run PSGI applications from
command line using L<Plack::Loader> to load PSGI backends. It can be
used to run standalone servers and FastCGI daemon processes. Other
server backends like Apache2 needs a separate configuration but
C<.psgi> application file can still be the same.

If you want to write your own frontend that replaces, or adds
functionalities to L<plackup>, take a look at L<Plack::Runner> module.

=head2 Plack::Middleware

PSGI middleware is a PSGI application that wraps existent PSGI
application and plays both side of application and servers. From the
servers the wrapped code reference still looks like and behaves
exactly the same as PSGI applications.

L<Plack::Middleware> gives you an easy way to wrap PSGI applications
with a clean API, and compatibility with L<Plack::Builder> DSL.

=head2 Plack::Builder

L<Plack::Builder> gives you a DSL that you can enable Middleware in
C<.psgi> files to wrap existent PSGI applications.

=head2 Plack::Request, Plack::Response

L<Plack::Request> gives you a nice wrapper API around PSGI C<$env>
hash to get headers, cookies and query parameters much like
L<Apache::Request> in mod_perl.

L<Plack::Response> does the same to construct the response array
reference.

=head2 Plack::Test

L<Plack::Test> is an unified interface to test your PSGI application
using standard L<HTTP::Request> and L<HTTP::Response> pair with simple
callbacks.

=head2 Plack::Test::Suite

L<Plack::Test::Suite> is a test suite to test a new PSGI server backend.

=head1 CONTRIBUTING

=head2 Patches and Bug Fixes

Small patches and bug fixes can be either submitted via nopaste on IRC
L<irc://irc.perl.org/#plack> or email. You could also fork on github
(http://github.com/miyagawa/Plack) to make larger fixes.

=head2 Module Namespaces

Modules added to the Plack:: sub-namespaces should be reasonably generic
components which are useful as building blocks and not just simply using
Plack.

Middleware authors are free to use the Plack::Middleware:: namespace for
their middleware components. Middleware must be written in the pipeline
style such that they can chained together with other middleware components.
The Plack::Middleware:: modules in the core distribution are good examples
of such modules. It is recommended that you inherit from L<Plack::Middleware>
for these types of modules.

Not all middleware components are wrappers, but instead are more like
endpoints in a middleware chain. These types of components should use the
Plack::App:: namespace. Again, look in the core modules to see excellent
examples of these (L<Plack::App::File>, L<Plack::App::Directory>, etc.).
It is recommended that you inherit from L<Plack::Component> for these
types of modules.

B<DO NOT USE> Plack:: namespace to build a new web application or a
framework. It's like naming your application under CGI:: namespace if
it's supposed to run on CGI and that is a really bad choice and
confuse people.

=head1 COPYRIGHT

Copyright 2009- Tatsuhiko Miyagawa

=head1 AUTHOR

Tatsuhiko Miyagawa

=head1 CONTRIBUTORS

Yuval Kogman (nothingmuch)

Tokuhiro Matsuno (tokuhirom)

Kazuhiro Osawa (Yappo)

Kzzuho Oku

Florian Ragwitz (rafl)

Chia-liang Kao (clkao)

Masahiro Honma (hiratara)

Daisuke Murase (typester)

John Beppu

Matt S Trout (mst)

Shawn M Moore (Sartak)

Stevan Little

Hans Dieter Pearcey (confound)

Tomas Doran (t0m)

mala

Mark Stosberg

Aaron Trevena

=head1 SEE ALSO

L<PSGI> L<http://plackperl.org/>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
