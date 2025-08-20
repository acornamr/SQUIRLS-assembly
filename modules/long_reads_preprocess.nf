process CALCULATE_GENOME_SIZE_LR {
    errorStrategy 'ignore'
    tag { meta.sample_id }    
    label 'process_medium'
    label 'lrge_container'

    input:
    tuple val(meta), path(long_reads)

    output:
    tuple val(meta), path(long_reads), path(genome_size)

    script:
    genome_size="${meta.sample_id}_genome_size.txt"
    //###count=\$(zcat $long_reads | grep -c "^@")
    """
    count=\$(zcat $long_reads | grep -c "^@")
    if [ \$count -lt 5000 ]; then
        lrge $long_reads -n \$count -o ${meta.sample_id}_genome_size.txt
    else
        lrge $long_reads -o ${meta.sample_id}_genome_size.txt
    fi
    """
}

process NANOPLOT {
    tag { meta.sample_id }
    label 'process_low'
    label 'nanoplot_container'

    publishDir "${params.outdir}/long_read_stats", mode: 'copy', pattern: '*.html'

    input:
    tuple val(meta), path(long_reads), path(genome_size)

    output:
    tuple val(meta), path("*.html"), emit: html

    script:
    LR="${long_reads}"

    """
    NanoPlot --fastq $LR -t $task.cpus -o nanoplot_out --no_static
    mv nanoplot_out/NanoPlot-report.html ${meta.sample_id}_nanoplot_report.html
    """
}


