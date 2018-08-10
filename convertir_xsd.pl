#!/usr/bin/perl

use warnings;  
use strict;
use Data::Dumper;
use XML::Compile::Schema;  
use XML::LibXML;

my $xsd = 'ejemplo.xsd'; ###Este es el archivo de la definición del XML, o sea el XSD
my $schema = XML::Compile::Schema->new($xsd);
my $template = $schema->template('PERL', 'addresses'); ###Obviamente aquí tienes que agregar los elementos que vengan en el xsd que te den
print "The template:\n $template\n\n";

### Aquí vuelve la definición en una estructura de datos en memoria, o sea una referencia a un hash
my $sample;
eval "\$sample = $template;";
print "The template turned into a Perl data structure:\n";
print Dumper( $sample );
print "\n\n";

## Aquí simplemente convierte el hashesin en un XML
my $doc    = XML::LibXML::Document->new('1.0', 'UTF-8'); 
my $write  = $schema->compile(WRITER => 'addresses'); 
my $xml    = $write->($doc, $sample);
$doc->setDocumentElement($xml);
print "The generated XML:\n";
### Aquí te imprime esto en cosola, pero simplemente tienes que comentarla y mandar a imprimir a un archivo para generarlo:
print $doc->toString(1);
print "\n\n";

## Ejemplo de escritura al archivo comentarías las dos líneas enteriores.
open (OUT, ">salida.xml");
print OUT $doc->toString(1);
close(OUT);
