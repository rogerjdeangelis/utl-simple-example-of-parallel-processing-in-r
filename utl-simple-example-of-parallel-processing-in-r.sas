%let pgm=utl-simple-example-of-parallel-processing-in-r;

Simple example of parallel processing in r

 Processor          Intel(R) Xeon(R) CPU E5-2667 v2 @ 3.30GHz x 3.30 GHz  (2 soketed processors)
 Logical Proessors  32    2x16
 Installed Ram      128
 Nvme Drives        Dual 1Tb

 Windows            Windows 10 Pro for Workstations
                    (workstation supports up to 4 socketed CPUs on the motherboard and 256 logical processors and 6Tb ram)
                    You can upgrade from pro for $125. It just changes a bit? in the kernal for no need to reboot)
                    Pro kernal is the same for all editions of Windows? even server.
                    We need soneone to sell the golden scredriver to change from one eidtion to more powerfull edition?

github
https://tinyurl.com/mr39knse
https://github.com/rogerjdeangelis/utl-simple-example-of-parallel-processing-in-r

https://gradientdescending.com/simple-parallel-processing-in-r/

Problem  ( Best case compute bound processes)

   Compute the mean square errors using 1, 2, 4, 8, 12, 16, 20, 24, 28, and 32 logical processors.
   Repeat for each cluster of logical processors.
            100,000 linear regressions using repeated random samples of size 200 from the boston dataset
     model   medv = crim zn indus chas nox rm age dis rad tax ptratio black lstat
     mse     mean((fitted.values(model) - medv^2);


Note
   2:1  114.5/225.9    2 processors is half the time(51%) of 1 processor
   4:2   61/114.5      4 processors is roughly half the time(53%) of 2 processors
   8:4   31.6/61       8 processors is roughly half the time(52%) of 4 processors
  16:8   17.9/31.6    16 processors is 56% of the 8 processor time

This is where it starts to breaks down

  24/12  18.78/21.93  24 is 86% of the 12 processor time?
  Is parallel able to utitlize my second socketed cpu?

/**************************************************************************************************************************/
/*                                                                                                                        */
/*             Utilization for 1, 2, 4, 8, 12, 16, 20, 24, 28, and 32 simutaneous logical processors                      */
/*                                                                                                                        */
/*  PROCESS    UTL_1    UTL_2    UTL_4   UTL_8    UTL_12    UTL_16    UTL_20    UTL_24    UTL_28    UTL_32                */
/*                                                                                                                        */
/*  ELAPSED                                                                    == BREAKS DOWN ===                         */
/*  SECONDS   225.89  114.50    61.94    31.61     21.92     17.89     18.94     17.78     17.15     16.26                */
/*                                                                                                                        */
/*      1       100      100      100      100       100       100       100       100       100       100                */
/*      2        11      100      100      100       100       100       100       100       100       100                */
/*      3        11       11      100      100       100       100       100       100       100       100                */
/*      4        11       11      100      100       100       100       100       100       100       100                */
/*      5        11       11       11      100       100       100       100       100       100       100                */
/*      6        11       11        5      100       100       100       100       100       100       100                */
/*      7         5        5        5      100       100       100       100       100       100       100                */
/*      8         5        5        5      100       100       100       100       100       100       100                */
/*      9         5        5        5        9       100       100       100       100       100       100                */
/*     10         5        5        5        9       100       100       100       100       100       100                */
/*     11         5        5        5        9       100       100       100       100       100       100                */
/*     12         5        5        5        9       100       100       100       100       100       100                */
/*     13         5        5        5        9         7       100       100       100       100       100                */
/*     14         5        5        5        9         7       100       100       100       100       100                */
/*     15         5        5        5        9         7       100       100       100       100       100                */
/*     16         5        5        5        9         7       100       100       100       100       100                */
/*     17         5        0        5        4         7        14       100       100       100       100                */
/*     18         0        0        5        4         7        14       100       100       100       100                */
/*     19         0        0        5        4         7         8       100       100       100       100                */
/*     20         0        0        5        4         7         8       100       100       100       100                */
/*     21         0        0        5        4         7         8        74       100       100       100                */
/*     22         0        0        5        4         7         8        58       100       100       100                */
/*     23         0        0        5        4         7         8        47       100       100       100                */
/*     24         0        0        5        4         7         8         7       100       100       100                */
/*     25         0        0        5        4         7         2         7        53       100       100                */
/*     26         0        0        5        4         1         2         7        33       100       100                */
/*     27         0        0        5        4         0         2         1        22       100       100                */
/*     28         0        0        5        4         0         2         1         0       100       100                */
/*     29         0        0        0        4         0         2         1         0        98       100                */
/*     30         0        0        0        4         0         2         1         0        86       100                */
/*     31         0        0        0        4         0         2         1         0        54       100                */
/*     32         0        0        0        4         0         2         1         0        44       100                */
/*                                                                                                                        */
/*                                                                                                                        */
/*                            LOGICAL_PROCESSORS                                                                          */
/*                                                                                                                        */
/*           0            10            20            30            40                                                    */
/*         --+-------------+-------------+-------------+-------------+--           data elap;                             */
/*         |                                                           |            input logical_processors              */
/*     250 +                                                           + 250            elapse_time_in_seconds;           */
/*         |                                                           |            num=put(logical_processors,2. -l);    */
/*         |  * 1                                                      |           cards4;                                */
/*         |                                                           |           1 225.89                               */
/*     200 +                                                           + 200       2 114.50                               */
/*         |                                                           |           4 61.94                                */
/*   E     |      NUMBER OF LOGICAL PROCESSORS                         |       E   8 31.61                                */
/*   L     |                                                           |       L   12 21.92                               */
/*   A 150 +                                                           + 150   A   16 17.45                               */
/*   P     |                                                           |       P   20 18.94                               */
/*   S     |                                                           |       S   24 17.78                               */
/*   E     |    * 2                                                    |       E   28 16.97                               */
/*   D 100 +                                                           + 100   D   32 16.26                               */
/*         |                                                           |           ;;;;                                   */
/*         |                                                           |           run;quit;                              */
/*         |       * 4                                                 |                                                  */
/*      50 +                                                           +  50       options ls=84 ps=32;                   */
/*         |            * 8                                            |           proc plot data=elap;                   */
/*         |                  * 12       * 20                          |             plot elapse_time_in_seconds          */
/*         |                       * 16        * 24 * 28  * 32         |              *logical_processors='*' $ num/box;  */
/*       0 +                                                           +   0       run;quit;                              */
/*         |                                                           |                                                  */
/*         --+-------------+-------------+-------------+-------------+--                                                  */
/*           0            10            20            30            40                                                    */
/*                                                                                                                        */
/*                              LOGICAL_PROCESSORS                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  R dataframe                                                                                                           */
/*                                                                                                                        */
/*  100,000  random samples of size 200 (up to 32 110k repeated random sample of size 200 for 32 simultaneos processors)  */
/*                                                                                                                        */
/*       CRIM ZN INDUS CHAS   NOX    RM  AGE    DIS RAD TAX PTRATIO  BLACK LSTAT  MEDV                                    */
/*                                                                                                                        */
/*  1 0.00632 18  2.31    0 0.538 6.575 65.2 4.0900   1 296    15.3 396.90  4.98  24.0                                    */
/*  2 0.02731  0  7.07    0 0.469 6.421 78.9 4.9671   2 242    17.8 396.90  9.14  21.6                                    */
/*  3 0.02729  0  7.07    0 0.469 7.185 61.1 4.9671   2 242    17.8 392.83  4.03  34.7                                    */
/*  4 0.03237  0  2.18    0 0.458 6.998 45.8 6.0622   3 222    18.7 394.63  2.94  33.4                                    */
/*  5 0.06905  0  2.18    0 0.458 7.147 54.2 6.0622   3 222    18.7 396.90  5.33  36.2                                    */
/*  6 0.02985  0  2.18    0 0.458 6.430 58.7 6.0622   3 222    18.7 394.12  5.21  28.7                                    */
/*  ...                                                                                                                   */
/*  200 ....                                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

%macro utl_process(num_process);
   %utl_submit_wps64x(resolve('
   proc r;
   submit;
   library(MASS);
   library(parallel);
   data(Boston);
   model.mse <- function(x) {
     id <- sample(1:nrow(Boston), 200, replace = T);
     mod <- lm(medv ~ ., data = Boston[id,]);
     mse <- mean((fitted.values(mod) - Boston$medv[id])^2);
     return(mse);
   };
   system.time({
     clust <- makeCluster(&num_process);
     clusterExport(clust, "Boston");
     a <- parSapply(clust, 1:1e5, model.mse)});
   endsubmit;
   '));
%mend utl_process;

%utl_process(1);
%utl_process(2);
%utl_process(4);
%utl_process(8);
%utl_process(12);
%utl_process(16);
%utl_process(20);
%utl_process(24);
%utl_process(28);
%utl_process(32);

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  1  Logical Processor (1 x 100,000 regressions on randon sample of 200 from Boston data)                               */
/*                                                                                                                        */
/*     user  system elapsed                                                                                               */
/*     0.08    0.05  225.89                                                                                               */
/*  ...                                                                                                                   */
/*  32  Logical Processors (1 x 100,000 regressions on randon sample of 200 from Boston data)                             */
/*                                                                                                                        */
/*     user  system elapsed                                                                                               */
/*     0.09    0.17   16.26                                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
