conda create -n homer_env -c bioconda homer -y
conda activate homer_env
################################ homer genome load
loadGenome.pl -name watermelon_0407 -fasta 97103_genome_v2.fa -gtf watermelon_97103_v2.gene_model.gtf -org null -force # preparation of other species -org null

######################################## peak annotation
input_dir="/data4/users/Qiuqoo/zjuatac/data_Delivery_20240625/macs2/"
genome="watermelon_0407"
output_dir="/data4/users/Qiuqoo/zjuatac/data_Delivery_20240625/macs2/annotated_peaks/"


mkdir -p "$output_dir"


for peak_file in "$input_dir"*.narrowPeak; do

    file_name=$(basename "$peak_file" .narrowPeak)

    annotatePeaks.pl "$peak_file" "$genome" > "$output_dir$file_name"_homer_annotation.txt
done

######################################## peak motif annotation
findMotifsGenome.pl <peak_file> <genome> <output_directory>

########
genome="watermelon_0407"
output_dir="/data4/users/Qiuqoo/zjuatac/data_Delivery_20240625/homer/motifs_output"

mkdir -p $output_dir

for peak_file in /data4/users/Qiuqoo/zjuatac/data_Delivery_20240625/macs2/*.narrowPeak; do
  
  filename=$(basename $peak_file)
  

  current_output_dir="$output_dir/$(basename $filename .narrowPeak)"
  
  mkdir -p $current_output_dir
  
  findMotifsGenome.pl $peak_file $genome $current_output_dir
done
