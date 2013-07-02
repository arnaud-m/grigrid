#!/usr/bin/python
##########################
# Author: A. Malapert                                    #
# Version: 0.0.1                                               #
# Licence: GPL                                                #
##########################



##########################
# Import of external classes and functions

import StringIO
import re
import textwrap
import logging
import sys
from sets import Set
import argparse
        
        
        
##########################
# Definition of functions         

def write_header(ostream, keys):
    for key in keys:
        ostream.write("%10s|" % key[key.strip().rfind(' ')+1:])
    ostream.write('\n')

def write_entry(ostream, results, keys):
    if len(results) == 0:
        logging.warning("Empty entry.")
    elif len(keys) != len(results):
        logging.warning("Missing fields: "+str(set(keys).difference(results.keys())))
    for key in keys:
        if results.has_key(key):
            ostream.write("%10s|" % results[key])
        else:
            ostream.write("%10s|" %  '')
    ostream.write('\n')

def parse_entries(istream, ostream, keys):
    results ={} 
    for line in istream:
        for key in keys:
            match=re.match(key, line);
            if match:
                if key in results: 
                    write_entry(ostream, results, keys)
                    results ={} 
                results[key]=line[match.end():].strip();
                break
    write_entry(ostream, results,keys)

##########################
# Definition of a main procedure 
if __name__ == "__main__":
    
    # Parse command line
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent('''\
%(prog)s does something useful 
 '''),
        epilog=textwrap.dedent('''\

%(prog)s 0.1
Copyright (C) 2011 Arnaud Malapert (UNS CNRS).
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.

This  is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.''')
        );
    parser.add_argument('--version', action='version', version='%(prog)s 0.1')
    parser.add_argument("-v", "--verbosity", help="increase verbosity", action="store_true")
    parser.add_argument('-k', '--keys', type=argparse.FileType('r'), help="text file containing the keys for log files.",required=True) 
    parser.add_argument('-i', '--input', type=argparse.FileType('r'),nargs='+',help="log files of solvers",required=True)
    parser.add_argument('-o', '--output', type=argparse.FileType('w'), help="output text file (Table with all results)") 
    args=parser.parse_args()

    if args.verbosity:
        logging.getLogger().setLevel(logging.DEBUG)

    ## Read keys from a file
    keys=[];
    for key in args.keys:
        key=key.strip()+' ';
        if key not in keys : keys.append(key)
    #print keys
    args.keys.close();

    ## Initialize output file
    extre = re.compile('\.[^\.]+$');
    if args.output :
        outfile = args.output
        write_header(outfile,keys)
    else :
        outfile=None
    ## Read and extract Table from log files
    for infile in args.input:
        if not args.output :
            if outfile : outfile.close();
            fname=extre.sub('.res',infile.name);
            outfile = open(fname, 'w')
            write_header(outfile,keys)
        logging.debug("EXTRACT %s -> %s" % (infile.name,outfile.name))
        parse_entries(infile,outfile,keys)
        infile.close()
    
   
    

    



