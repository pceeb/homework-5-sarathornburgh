#!/bin/bash


# This script combines an OTU file with sequencing data and a taxonomic file into one, complete file to prep for statistical analysis.
# The user should input the names (not including the )for their OTU file with sequencing data and then their taxonomic file in the command prompt calling this script. 


# The following replaces the ";" delimiter with a tab for both files and outputs it to a file calles $*_tab.tsv
sed 's/;/\t/g' $1.tsv > $1_tab.tsv
sed 's/;/\t/g' $2.tsv > $2_tab.tsv

# The following takes the header from the OTU file with sequencing data and adds it into a separate file called $1_header.tsv.

grep '#' $1_tab.tsv > $1_header.tsv


# The following takes the data from the OTU file with sequencing data and adds it into a separate file called $1_data.tsv.

tail -n+2 $1_tab.tsv > $1_data.tsv


# The following sorts the data from the OTU file alphabetically by the first column (which should contain the ID names), and adds it to a separate file called $1_sorted_data.tsv.

sort -k1 $1_data.tsv > $1_sorted_data.tsv


# The following adds both the header and the sorted data into a new file called $1_sorted.tsv. 

cat $1_header.tsv $1_sorted_data.tsv > $1_sorted.tsv


# The following takes the header from the taxonomic file and adds it into a separate file called $2_header.tsv.

grep '#' $2_tab.tsv > $2_header.tsv


# The following takes the taxonomies from the taxonomic file and adds it into a separate file called $2_data.tsv.

tail -n+2 $2_tab.tsv > $2_data.tsv


# The following sorts the taxonomies from the taxonomic file alphabetically by the first column (which should contain the ID names), and adds it to a separate file called $2_sorted_data.tsv

sort -k1 $2_data.tsv > $2_sorted_data.tsv


# The following adds both the header and the sorted data into a new file called $2_sorted.tsv.

cat $2_header.tsv $2_sorted_data.tsv > $2_sorted.tsv


# The following adds both the OTU file with sequencing data and the taxonomic file together into a file called combined_$1_$2.tsv.

paste $2_sorted.tsv $1_sorted.tsv > combined_$1_$2.tsv


# The following removes all the files made while running the script.

rm $1_tab.tsv

rm $1_header.tsv

rm $1_data.tsv

rm $1_sorted_data.tsv

rm $1_sorted.tsv

rm $2_tab.tsv

rm $2_header.tsv

rm $2_data.tsv

rm $2_sorted_data.tsv

rm $2_sorted.tsv
