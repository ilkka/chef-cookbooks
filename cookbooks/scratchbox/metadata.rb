maintainer       "Ilkka Laukkanen"
maintainer_email "ilkka.s.laukkanen@gmail.com"
license          "Apache 2.0"
description      "Installs and configures scratchbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

attribute 'scratchbox/fullname',
  :display_name => 'Full name',
  :type => 'string',
  :required => 'required'

attribute 'scratchbox/email',
  :display_name => 'Email address',
  :type => 'string',
  :required => 'required'

