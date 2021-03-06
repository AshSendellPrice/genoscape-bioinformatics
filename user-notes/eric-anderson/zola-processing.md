Notes while processing *Zosterops lateralis* RAD reads
================
07 November, 2016

-   [Notes on Exact Steps in the Processing](#notes-on-exact-steps-in-the-processing)
-   [Reads with "more read characters than quality values" during bowtie mapping](#reads-with-more-read-characters-than-quality-values-during-bowtie-mapping)
    -   [Looking at Plate\_2:](#looking-at-plate_2)
    -   [Looking at Plate\_1](#looking-at-plate_1)
    -   [Aha! The `process_radtags` must have crapped out at some point](#aha-the-process_radtags-must-have-crapped-out-at-some-point)

<!-- README.md is generated from README.Rmd. Please edit that file -->
Notes on Exact Steps in the Processing
--------------------------------------

Ultimately, this is where I would like to put a detailed, easy to follow listing of the actual commands used....Of course, I launched most of the steps before I actually started this document.

Reads with "more read characters than quality values" during bowtie mapping
---------------------------------------------------------------------------

There is a problem with some individuals on Plate\_2 during the alignment stage with `bowtie`.
This did not happen with any individuals on Plate\_1. It could be some wackiness in `process_radtags`. Someone was complaining about it after upgrading STACKS from 1.29 to 1.35. That thread can be found [here](https://groups.google.com/forum/#!topic/stacks-users/JNMVAUdHUiQ). I suspect something like that is going on here.

### Looking at Plate\_2:

To have a further look at which individuals this is happening out and how much of the original `dupfitered` data is being lost when it dumps core, I did this:

``` sh
[kruegg@login2 reports]$ pwd
/u/home/k/kruegg/nobackup-klohmuel/ZOLA/Plate_2/alignments/ZOLAv0/reports
[kruegg@login2 reports]$ for i in *; do echo  $i $(grep Error $i) $(du -h ../bam/$i.bam) $(du -h ../../../dupfiltered/${i/zola-2./}.1.1.fq.gz) $(du -h ../../../dupfiltered/${i/zola-2./}.2.2.fq.gz) ; done  
zola-2.12-049 Error: Read 3_2209_21704_18142_1 has more read characters than quality values. 114M ../bam/zola-2.12-049.bam 72M ../../../dupfiltered/12-049.1.1.fq.gz 88M ../../../dupfiltered/12-049.2.2.fq.gz
zola-2.12-050 132M ../bam/zola-2.12-050.bam 52M ../../../dupfiltered/12-050.1.1.fq.gz 63M ../../../dupfiltered/12-050.2.2.fq.gz
zola-2.12-051 214M ../bam/zola-2.12-051.bam 82M ../../../dupfiltered/12-051.1.1.fq.gz 102M ../../../dupfiltered/12-051.2.2.fq.gz
zola-2.12-053 306M ../bam/zola-2.12-053.bam 119M ../../../dupfiltered/12-053.1.1.fq.gz 146M ../../../dupfiltered/12-053.2.2.fq.gz
zola-2.12-056 22M ../bam/zola-2.12-056.bam 8.1M ../../../dupfiltered/12-056.1.1.fq.gz 9.7M ../../../dupfiltered/12-056.2.2.fq.gz
zola-2.12-057 60M ../bam/zola-2.12-057.bam 23M ../../../dupfiltered/12-057.1.1.fq.gz 28M ../../../dupfiltered/12-057.2.2.fq.gz
zola-2.12-060 Error: Read 3_2209_21471_16577_2 has more read characters than quality values. 118M ../bam/zola-2.12-060.bam 63M ../../../dupfiltered/12-060.1.1.fq.gz 77M ../../../dupfiltered/12-060.2.2.fq.gz
zola-2.12-066 602M ../bam/zola-2.12-066.bam 237M ../../../dupfiltered/12-066.1.1.fq.gz 290M ../../../dupfiltered/12-066.2.2.fq.gz
zola-2.12-067 Error: Read 3_2208_30573_48386_2 has more read characters than quality values. 8.2M ../bam/zola-2.12-067.bam 8.2M ../../../dupfiltered/12-067.1.1.fq.gz 9.5M ../../../dupfiltered/12-067.2.2.fq.gz
zola-2.APB373 664M ../bam/zola-2.APB373.bam 259M ../../../dupfiltered/APB373.1.1.fq.gz 323M ../../../dupfiltered/APB373.2.2.fq.gz
zola-2.APB382 41M ../bam/zola-2.APB382.bam 16M ../../../dupfiltered/APB382.1.1.fq.gz 19M ../../../dupfiltered/APB382.2.2.fq.gz
zola-2.APB390 34M ../bam/zola-2.APB390.bam 13M ../../../dupfiltered/APB390.1.1.fq.gz 16M ../../../dupfiltered/APB390.2.2.fq.gz
zola-2.APB401 Error: Read 3_2209_30705_17913_2 has more read characters than quality values. 413M ../bam/zola-2.APB401.bam 220M ../../../dupfiltered/APB401.1.1.fq.gz 272M ../../../dupfiltered/APB401.2.2.fq.gz
zola-2.APB409 Error: Read 3_2209_6309_19214_1 has more read characters than quality values. 519M ../bam/zola-2.APB409.bam 255M ../../../dupfiltered/APB409.1.1.fq.gz 317M ../../../dupfiltered/APB409.2.2.fq.gz
zola-2.CDH25 25M ../bam/zola-2.CDH25.bam 9.4M ../../../dupfiltered/CDH25.1.1.fq.gz 11M ../../../dupfiltered/CDH25.2.2.fq.gz
zola-2.CDH26 56M ../bam/zola-2.CDH26.bam 22M ../../../dupfiltered/CDH26.1.1.fq.gz 26M ../../../dupfiltered/CDH26.2.2.fq.gz
zola-2.CDH44 154M ../bam/zola-2.CDH44.bam 59M ../../../dupfiltered/CDH44.1.1.fq.gz 74M ../../../dupfiltered/CDH44.2.2.fq.gz
zola-2.CDH46 Error: Read 3_2209_3894_17104_2 has more read characters than quality values. 87M ../bam/zola-2.CDH46.bam 224M ../../../dupfiltered/CDH46.1.1.fq.gz 278M ../../../dupfiltered/CDH46.2.2.fq.gz
zola-2.CI10 87M ../bam/zola-2.CI10.bam 33M ../../../dupfiltered/CI10.1.1.fq.gz 41M ../../../dupfiltered/CI10.2.2.fq.gz
zola-2.CI11 291M ../bam/zola-2.CI11.bam 134M ../../../dupfiltered/CI11.1.1.fq.gz 138M ../../../dupfiltered/CI11.2.2.fq.gz
zola-2.CI13 Error: Read 3_2209_5477_12427_2 has more read characters than quality values. 32M ../bam/zola-2.CI13.bam 31M ../../../dupfiltered/CI13.1.1.fq.gz 39M ../../../dupfiltered/CI13.2.2.fq.gz
zola-2.CI20 90M ../bam/zola-2.CI20.bam 35M ../../../dupfiltered/CI20.1.1.fq.gz 43M ../../../dupfiltered/CI20.2.2.fq.gz
zola-2.CI21 274M ../bam/zola-2.CI21.bam 107M ../../../dupfiltered/CI21.1.1.fq.gz 131M ../../../dupfiltered/CI21.2.2.fq.gz
zola-2.CI23 131M ../bam/zola-2.CI23.bam 49M ../../../dupfiltered/CI23.1.1.fq.gz 62M ../../../dupfiltered/CI23.2.2.fq.gz
zola-2.CI24 133M ../bam/zola-2.CI24.bam 51M ../../../dupfiltered/CI24.1.1.fq.gz 63M ../../../dupfiltered/CI24.2.2.fq.gz
zola-2.CI25 366M ../bam/zola-2.CI25.bam 143M ../../../dupfiltered/CI25.1.1.fq.gz 176M ../../../dupfiltered/CI25.2.2.fq.gz
zola-2.CI26 590M ../bam/zola-2.CI26.bam 228M ../../../dupfiltered/CI26.1.1.fq.gz 285M ../../../dupfiltered/CI26.2.2.fq.gz
zola-2.CI27 Error: Read 3_2209_29335_11812_2 has more read characters than quality values. 50M ../bam/zola-2.CI27.bam 36M ../../../dupfiltered/CI27.1.1.fq.gz 44M ../../../dupfiltered/CI27.2.2.fq.gz
zola-2.CI28 315M ../bam/zola-2.CI28.bam 122M ../../../dupfiltered/CI28.1.1.fq.gz 151M ../../../dupfiltered/CI28.2.2.fq.gz
zola-2.CI29 976M ../bam/zola-2.CI29.bam 387M ../../../dupfiltered/CI29.1.1.fq.gz 471M ../../../dupfiltered/CI29.2.2.fq.gz
zola-2.CI30 544M ../bam/zola-2.CI30.bam 216M ../../../dupfiltered/CI30.1.1.fq.gz 262M ../../../dupfiltered/CI30.2.2.fq.gz
zola-2.CI31 65M ../bam/zola-2.CI31.bam 25M ../../../dupfiltered/CI31.1.1.fq.gz 30M ../../../dupfiltered/CI31.2.2.fq.gz
zola-2.CI32 660M ../bam/zola-2.CI32.bam 249M ../../../dupfiltered/CI32.1.1.fq.gz 321M ../../../dupfiltered/CI32.2.2.fq.gz
zola-2.CI33 343M ../bam/zola-2.CI33.bam 129M ../../../dupfiltered/CI33.1.1.fq.gz 166M ../../../dupfiltered/CI33.2.2.fq.gz
zola-2.CI34 449M ../bam/zola-2.CI34.bam 175M ../../../dupfiltered/CI34.1.1.fq.gz 216M ../../../dupfiltered/CI34.2.2.fq.gz
zola-2.CI35 534M ../bam/zola-2.CI35.bam 209M ../../../dupfiltered/CI35.1.1.fq.gz 258M ../../../dupfiltered/CI35.2.2.fq.gz
zola-2.CI36 Error: Read 3_2209_32502_17157_1 has more read characters than quality values. 203M ../bam/zola-2.CI36.bam 94M ../../../dupfiltered/CI36.1.1.fq.gz 117M ../../../dupfiltered/CI36.2.2.fq.gz
zola-2.CI37 78M ../bam/zola-2.CI37.bam 30M ../../../dupfiltered/CI37.1.1.fq.gz 37M ../../../dupfiltered/CI37.2.2.fq.gz
zola-2.CI39 255M ../bam/zola-2.CI39.bam 99M ../../../dupfiltered/CI39.1.1.fq.gz 122M ../../../dupfiltered/CI39.2.2.fq.gz
zola-2.CI40 69M ../bam/zola-2.CI40.bam 27M ../../../dupfiltered/CI40.1.1.fq.gz 32M ../../../dupfiltered/CI40.2.2.fq.gz
zola-2.D10 Error: Read 3_2209_14976_18124_2 has more read characters than quality values. 250M ../bam/zola-2.D10.bam 201M ../../../dupfiltered/D10.1.1.fq.gz 249M ../../../dupfiltered/D10.2.2.fq.gz
zola-2.D12 178M ../bam/zola-2.D12.bam 67M ../../../dupfiltered/D12.1.1.fq.gz 85M ../../../dupfiltered/D12.2.2.fq.gz
zola-2.D13 413M ../bam/zola-2.D13.bam 161M ../../../dupfiltered/D13.1.1.fq.gz 199M ../../../dupfiltered/D13.2.2.fq.gz
zola-2.D14 717M ../bam/zola-2.D14.bam 283M ../../../dupfiltered/D14.1.1.fq.gz 346M ../../../dupfiltered/D14.2.2.fq.gz
zola-2.D15 409M ../bam/zola-2.D15.bam 161M ../../../dupfiltered/D15.1.1.fq.gz 197M ../../../dupfiltered/D15.2.2.fq.gz
zola-2.D16 42M ../bam/zola-2.D16.bam 16M ../../../dupfiltered/D16.1.1.fq.gz 20M ../../../dupfiltered/D16.2.2.fq.gz
zola-2.D18 Error: Read 3_2209_14661_13922_1 has more read characters than quality values. 25M ../bam/zola-2.D18.bam 39M ../../../dupfiltered/D18.1.1.fq.gz 47M ../../../dupfiltered/D18.2.2.fq.gz
zola-2.D2 84M ../bam/zola-2.D2.bam 32M ../../../dupfiltered/D2.1.1.fq.gz 40M ../../../dupfiltered/D2.2.2.fq.gz
zola-2.D20 196M ../bam/zola-2.D20.bam 73M ../../../dupfiltered/D20.1.1.fq.gz 94M ../../../dupfiltered/D20.2.2.fq.gz
zola-2.D21 Error: Read 3_2209_21257_17087_2 has more read characters than quality values. 40M ../bam/zola-2.D21.bam 82M ../../../dupfiltered/D21.1.1.fq.gz 100M ../../../dupfiltered/D21.2.2.fq.gz
zola-2.D22 428M ../bam/zola-2.D22.bam 169M ../../../dupfiltered/D22.1.1.fq.gz 206M ../../../dupfiltered/D22.2.2.fq.gz
zola-2.D23 319M ../bam/zola-2.D23.bam 123M ../../../dupfiltered/D23.1.1.fq.gz 154M ../../../dupfiltered/D23.2.2.fq.gz
zola-2.D24 Error: Read 3_2209_23206_16207_1 has more read characters than quality values. 299M ../bam/zola-2.D24.bam 114M ../../../dupfiltered/D24.1.1.fq.gz 145M ../../../dupfiltered/D24.2.2.fq.gz
zola-2.D25 769M ../bam/zola-2.D25.bam 303M ../../../dupfiltered/D25.1.1.fq.gz 372M ../../../dupfiltered/D25.2.2.fq.gz
zola-2.D26 102M ../bam/zola-2.D26.bam 39M ../../../dupfiltered/D26.1.1.fq.gz 49M ../../../dupfiltered/D26.2.2.fq.gz
zola-2.D27 Error: Read 3_2209_27285_17860_2 has more read characters than quality values. 176M ../bam/zola-2.D27.bam 127M ../../../dupfiltered/D27.1.1.fq.gz 156M ../../../dupfiltered/D27.2.2.fq.gz
zola-2.D28 Error: Read 3_2209_6573_16788_2 has more read characters than quality values. 169M ../bam/zola-2.D28.bam 153M ../../../dupfiltered/D28.1.1.fq.gz 189M ../../../dupfiltered/D28.2.2.fq.gz
zola-2.D29 258M ../bam/zola-2.D29.bam 100M ../../../dupfiltered/D29.1.1.fq.gz 124M ../../../dupfiltered/D29.2.2.fq.gz
zola-2.D3 57M ../bam/zola-2.D3.bam 22M ../../../dupfiltered/D3.1.1.fq.gz 27M ../../../dupfiltered/D3.2.2.fq.gz
zola-2.D30 229M ../bam/zola-2.D30.bam 88M ../../../dupfiltered/D30.1.1.fq.gz 110M ../../../dupfiltered/D30.2.2.fq.gz
zola-2.D5 399M ../bam/zola-2.D5.bam 155M ../../../dupfiltered/D5.1.1.fq.gz 192M ../../../dupfiltered/D5.2.2.fq.gz
zola-2.D8 146M ../bam/zola-2.D8.bam 57M ../../../dupfiltered/D8.1.1.fq.gz 69M ../../../dupfiltered/D8.2.2.fq.gz
zola-2.D9 437M ../bam/zola-2.D9.bam 174M ../../../dupfiltered/D9.1.1.fq.gz 211M ../../../dupfiltered/D9.2.2.fq.gz
zola-2.GT129 64M ../bam/zola-2.GT129.bam 25M ../../../dupfiltered/GT129.1.1.fq.gz 30M ../../../dupfiltered/GT129.2.2.fq.gz
zola-2.L536 109M ../bam/zola-2.L536.bam 43M ../../../dupfiltered/L536.1.1.fq.gz 52M ../../../dupfiltered/L536.2.2.fq.gz
zola-2.L541 8.9M ../bam/zola-2.L541.bam 3.5M ../../../dupfiltered/L541.1.1.fq.gz 4.1M ../../../dupfiltered/L541.2.2.fq.gz
zola-2.LH101 153M ../bam/zola-2.LH101.bam 58M ../../../dupfiltered/LH101.1.1.fq.gz 73M ../../../dupfiltered/LH101.2.2.fq.gz
zola-2.LH102 144M ../bam/zola-2.LH102.bam 56M ../../../dupfiltered/LH102.1.1.fq.gz 69M ../../../dupfiltered/LH102.2.2.fq.gz
zola-2.LH103 84M ../bam/zola-2.LH103.bam 32M ../../../dupfiltered/LH103.1.1.fq.gz 40M ../../../dupfiltered/LH103.2.2.fq.gz
zola-2.LH107 253M ../bam/zola-2.LH107.bam 97M ../../../dupfiltered/LH107.1.1.fq.gz 122M ../../../dupfiltered/LH107.2.2.fq.gz
zola-2.LH108 231M ../bam/zola-2.LH108.bam 87M ../../../dupfiltered/LH108.1.1.fq.gz 110M ../../../dupfiltered/LH108.2.2.fq.gz
zola-2.LH118 650M ../bam/zola-2.LH118.bam 255M ../../../dupfiltered/LH118.1.1.fq.gz 313M ../../../dupfiltered/LH118.2.2.fq.gz
zola-2.LH119 Error: Read 3_2209_2940_12568_2 has more read characters than quality values. 78M ../bam/zola-2.LH119.bam 37M ../../../dupfiltered/LH119.1.1.fq.gz 46M ../../../dupfiltered/LH119.2.2.fq.gz
zola-2.PO2-092 864M ../bam/zola-2.PO2-092.bam 349M ../../../dupfiltered/PO2-092.1.1.fq.gz 415M ../../../dupfiltered/PO2-092.2.2.fq.gz
zola-2.PO2-095 144M ../bam/zola-2.PO2-095.bam 55M ../../../dupfiltered/PO2-095.1.1.fq.gz 68M ../../../dupfiltered/PO2-095.2.2.fq.gz
zola-2.PO2-098 Error: Read 3_2209_10033_19056_1 has more read characters than quality values. 305M ../bam/zola-2.PO2-098.bam 206M ../../../dupfiltered/PO2-098.1.1.fq.gz 251M ../../../dupfiltered/PO2-098.2.2.fq.gz
zola-2.PO7-064 117M ../bam/zola-2.PO7-064.bam 44M ../../../dupfiltered/PO7-064.1.1.fq.gz 56M ../../../dupfiltered/PO7-064.2.2.fq.gz
zola-2.PO7-065 Error: Read 3_2203_28869_15750_2 has more read characters than quality values. 1.6M ../bam/zola-2.PO7-065.bam 684K ../../../dupfiltered/PO7-065.1.1.fq.gz 692K ../../../dupfiltered/PO7-065.2.2.fq.gz
zola-2.PO7-066 201M ../bam/zola-2.PO7-066.bam 76M ../../../dupfiltered/PO7-066.1.1.fq.gz 96M ../../../dupfiltered/PO7-066.2.2.fq.gz
zola-2.SE_109 32M ../bam/zola-2.SE_109.bam 12M ../../../dupfiltered/SE_109.1.1.fq.gz 15M ../../../dupfiltered/SE_109.2.2.fq.gz
zola-2.SE_110 58M ../bam/zola-2.SE_110.bam 23M ../../../dupfiltered/SE_110.1.1.fq.gz 27M ../../../dupfiltered/SE_110.2.2.fq.gz
zola-2.SE_111 Error: Read 3_2209_14793_16823_1 has more read characters than quality values. 98M ../bam/zola-2.SE_111.bam 74M ../../../dupfiltered/SE_111.1.1.fq.gz 90M ../../../dupfiltered/SE_111.2.2.fq.gz
zola-2.SE_112 27M ../bam/zola-2.SE_112.bam 11M ../../../dupfiltered/SE_112.1.1.fq.gz 12M ../../../dupfiltered/SE_112.2.2.fq.gz
zola-2.SE_113 374M ../bam/zola-2.SE_113.bam 145M ../../../dupfiltered/SE_113.1.1.fq.gz 180M ../../../dupfiltered/SE_113.2.2.fq.gz
zola-2.SE_114 26M ../bam/zola-2.SE_114.bam 9.8M ../../../dupfiltered/SE_114.1.1.fq.gz 12M ../../../dupfiltered/SE_114.2.2.fq.gz
zola-2.SE_115 Error: Read 3_2209_25296_17157_1 has more read characters than quality values. 232M ../bam/zola-2.SE_115.bam 93M ../../../dupfiltered/SE_115.1.1.fq.gz 115M ../../../dupfiltered/SE_115.2.2.fq.gz
zola-2.SE_118 Error: Read 3_2209_4026_17333_2 has more read characters than quality values. 167M ../bam/zola-2.SE_118.bam 134M ../../../dupfiltered/SE_118.1.1.fq.gz 165M ../../../dupfiltered/SE_118.2.2.fq.gz
zola-2.SE_119 538M ../bam/zola-2.SE_119.bam 209M ../../../dupfiltered/SE_119.1.1.fq.gz 260M ../../../dupfiltered/SE_119.2.2.fq.gz
zola-2.SE_120 45M ../bam/zola-2.SE_120.bam 18M ../../../dupfiltered/SE_120.1.1.fq.gz 21M ../../../dupfiltered/SE_120.2.2.fq.gz
zola-2.SE_121 439M ../bam/zola-2.SE_121.bam 170M ../../../dupfiltered/SE_121.1.1.fq.gz 211M ../../../dupfiltered/SE_121.2.2.fq.gz
zola-2.SE_122 390M ../bam/zola-2.SE_122.bam 150M ../../../dupfiltered/SE_122.1.1.fq.gz 188M ../../../dupfiltered/SE_122.2.2.fq.gz
zola-2.SE_124 Error: Read 3_2209_23612_17544_2 has more read characters than quality values. 622M ../bam/zola-2.SE_124.bam 284M ../../../dupfiltered/SE_124.1.1.fq.gz 342M ../../../dupfiltered/SE_124.2.2.fq.gz
zola-2.SE_125 160M ../bam/zola-2.SE_125.bam 61M ../../../dupfiltered/SE_125.1.1.fq.gz 76M ../../../dupfiltered/SE_125.2.2.fq.gz
zola-2.SE_126 18M ../bam/zola-2.SE_126.bam 6.8M ../../../dupfiltered/SE_126.1.1.fq.gz 7.8M ../../../dupfiltered/SE_126.2.2.fq.gz
zola-2.SE_127 681M ../bam/zola-2.SE_127.bam 272M ../../../dupfiltered/SE_127.1.1.fq.gz 327M ../../../dupfiltered/SE_127.2.2.fq.gz
zola-2.SE_128 Error: Read 3_2209_25702_13464_1 has more read characters than quality values. 101M ../bam/zola-2.SE_128.bam 43M ../../../dupfiltered/SE_128.1.1.fq.gz 53M ../../../dupfiltered/SE_128.2.2.fq.gz
[kruegg@login2 reports]$ 
```

That is a little hard to read. It prints the name of the indiv and the error message if there was an error; the size and name of the *resulting* bam file; the size and name of the read1 input; the size and name of the read2 input. So, from this it is clear that we are losing a lot of sequence from these individuals that have thrown errors.

### Looking at Plate\_1

Here we just confirm that no such error occurred in the mapping of Plate\_1:

``` sh
[kruegg@login4 reports]$ pwd
/u/home/k/kruegg/nobackup-klohmuel/ZOLA/Plate_1/alignments/ZOLAv0/reports
[kruegg@login4 reports]$ grep Error * | wc 
      0       0       0
      
# Yep! No errors. And below we confirm that each mapping report has a consistent
# number of lines in it:
[kruegg@login4 reports]$ wc *
   15    83   630 zola-1.12-052
   15    83   612 zola-1.12-054
   15    83   616 zola-1.12-055
   15    83   612 zola-1.12-058
   15    83   606 zola-1.12-059
   15    83   622 zola-1.12-061
   15    83   616 zola-1.12-062
   15    83   616 zola-1.12-063
   15    83   628 zola-1.12-064
   15    83   615 zola-1.12-065
   15    83   627 zola-1.12-068
   15    83   603 zola-1.APB109
   15    83   626 zola-1.APB113
   15    83   624 zola-1.APB117
   15    83   618 zola-1.APB119
   15    83   610 zola-1.APB161
   15    83   623 zola-1.APB163
   15    83   620 zola-1.APB164
   15    83   615 zola-1.APB165
   15    83   621 zola-1.APB166
   15    83   604 zola-1.APB368
   15    83   624 zola-1.APB371
   15    83   622 zola-1.APB372
   15    83   607 zola-1.APB380
   15    83   628 zola-1.APB381
   15    83   590 zola-1.APB389
   15    83   618 zola-1.APB398
   15    83   609 zola-1.APB411
   15    83   597 zola-1.APB72
   15    83   599 zola-1.APB77
   15    83   623 zola-1.CDH16
   15    83   610 zola-1.CDH17
   15    83   627 zola-1.CDH18
   15    83   619 zola-1.CDH19
   15    83   624 zola-1.CDH20
   15    83   610 zola-1.CDH21
   15    83   625 zola-1.CDH22
   15    83   623 zola-1.CDH23
   15    83   623 zola-1.CDH24
   15    83   607 zola-1.CDH43
   15    83   619 zola-1.CDH45
   15    83   623 zola-1.CDH47
   15    83   627 zola-1.CDH48
   15    83   623 zola-1.CDH49
   15    83   628 zola-1.CDH50
   15    83   620 zola-1.CDH54
   15    83   612 zola-1.GT120
   15    83   631 zola-1.GT132
   15    83   628 zola-1.GT136
   15    83   614 zola-1.GT150
   15    83   622 zola-1.GT156
   15    83   623 zola-1.GT203
   15    83   626 zola-1.GT224
   15    83   608 zola-1.GT233
   15    83   622 zola-1.GT239
   15    83   622 zola-1.L519
   15    83   623 zola-1.L537
   15    83   621 zola-1.L538
   15    83   623 zola-1.L539
   15    83   622 zola-1.L549
   15    83   624 zola-1.L550
   15    83   623 zola-1.L591
   15    83   623 zola-1.L593
   15    83   622 zola-1.L594
   15    83   628 zola-1.L595
   15    83   610 zola-1.L596
   15    83   615 zola-1.L604
   15    83   628 zola-1.L613
   15    83   622 zola-1.L618
   15    83   612 zola-1.L619
   15    83   610 zola-1.L620
   15    83   616 zola-1.L645
   15    83   628 zola-1.L656
   15    83   630 zola-1.LH104
   15    83   610 zola-1.LH105
   15    83   626 zola-1.LH106
   15    83   610 zola-1.LH113
   15    83   624 zola-1.LH114
   15    83   630 zola-1.LH115
   15    83   626 zola-1.LH116
   15    83   623 zola-1.LH117
   15    83   630 zola-1.LH128
   15    83   619 zola-1.LH129
   15    83   623 zola-1.LH130
   15    83   624 zola-1.LH131
   15    83   623 zola-1.LH132
   15    83   630 zola-1.N107
   15    83   623 zola-1.N108
   15    83   627 zola-1.N109
   15    83   631 zola-1.N110
   15    83   631 zola-1.N206
   15    83   629 zola-1.N208
   15    83   621 zola-1.N209
   15    83   630 zola-1.N211
   15    83   622 zola-1.N212
   15    83   631 zola-1.N213
 1440  7968 59520 total
```

So, it is clearly a problem with Plate2

### Aha! The `process_radtags` must have crapped out at some point

If I look in the `demultiplex` directory for Plate\_2 I find that `zcat` fails with an unexpected end of file. It appears that every file is corrupted. It may be that this job was running when we ran out of space on the disk, or perhaps it got killed halfway through. At any rate, it leaves partial records at the end like this:

``` sh
[kruegg@login4 demultiplexed]$ pwd
/u/home/k/kruegg/nobackup-klohmuel/ZOLA/Plate_2_first_attempt/demultiplexed
[kruegg@login4 demultiplexed]$ zcat 12-067.2.fq.gz | tail -n 10 

gzip: 12-067.2.fq.gz: unexpected end of file
+
AAFFFAJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJFJ7JJJJFJJJJFJJJJJ<JJJJJJJJFJJJJJJJJJJFJJJJJJJJJJJJJJJJJJFFJFJJFJJFJJJJJJJJJJJJJFJJJJJJJFAJFFJJJAJJJJJJJJ7AJJ
@3_2208_22424_48368_2
CAGTACAGCAAAATATATCCAAGGAAACTTTTAGCTAAAAATCATATTTCACACAAAAGTGATTAAAGAACAACACTAAATACTTCTGTAGCTTTTTTAGATTTACAGTAGGTAACACTAACTAACCTTTCTTTTCAGGACCTAAAAAGA
+
<AAFFJJFJJJJJJJJJJFFFFFAFFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJFFJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJFJJFJJJJJJFJJJJJJJJAJJJJA<A<7AFJFJFJJF<
@3_2208_30573_48386_2
CCTCAAGGGCATCACAGCATGTTCTTGTGCAGTGCAATTTTACATAGTTCAACTGTCAATATTTAGCAAAAGCATACAGGCAAAAGAGCGAGGAAAGTATGTTGCAAGAATGGGATCTTCATAGTGTACACTTAAATCCCAAACAGTTAA
+
AA<FFFJFJJJF-FFFJJJJJJJJJJJFFJJJJJFJJJJJ-FJJFJJJJ-<JJJ-
```

When the unexpected break occurs in the middle of the quality scores, then it causes problems later on.

OK, let's see how things turn out once we re-run this.
