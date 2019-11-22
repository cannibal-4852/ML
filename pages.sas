/*
AUTHOR 	   :KD
DATE       :2019-08-22

In listing, Cour New, pt=8, one row's capability is 134.5 char,161.5 space.
In listing, Song,     pt=8, one row's capability is 134.5 asscii char,161.5 chinese char.
Macro used : %strToMvar, %__inner(), %__lines() 
1. Column's name prefixed as '__' better not appear in your dataset.
2. inds    : input dataset
   outds   : output dataset contains page variable.
   cols    : Columns displayed in RTF, seperated by space.
   colWidth: Columns' width in proc report, seperated by space.
   option  : just view source code
   maxRows : One page's capacity in RTF for sepecific font, fontsize, titles, footnotes.
   orderby : Same order as input dataset, and in proc report, those variables must act as  / order ....
   blockby : If you do not display some rows ( here i call it block) in different pages, please this parameter to control.
   	         Still not completed.
   skipby  : If you want add one null row after or before some block,because the null row also occupys space.
             Still not completed.
*/
%macro pages(inds,outds,cols,colWidths,orderby=,option=1,maxRows=28);
	/*(8.99/160,8.99/161)*/
	/*(8.99/133,8.99/134)*/
	%global __style;
	%if        &option = 1  %then %let __style = __List__US;
	%else %if  &option = 2  %then %let __style = __List__CN;
/*	%else %if  &option = 3  %then %let __style = __Table_US
	%else %if  &option = 4  %then %let __style = __Table_CN */
	%else %abort; 
	
	proc format;
		invalue __List__US
			" "   = 0.03100
			other = 0.06700
		;
		
		invalue __List__CN
		    "a"  =  0.05567
		    "b"  =  0.05567
		    "c"  =  0.05567
		    "d"  =  0.05567
		    "e"  =  0.05567
		    "f"  =  0.05567
		    "g"  =  0.05567
		    "h"  =  0.05567
		    "i"  =  0.05567
		    "j"  =  0.05567
		    "k"  =  0.05567
		    "l"  =  0.05567
		    "m"  =  0.05567
		    "n"  =  0.05567
		    "o"  =  0.05567
		    "p"  =  0.05567
		    "q"  =  0.05567
		    "r"  =  0.05567
		    "s"  =  0.05567
		    "t"  =  0.05567
		    "u"  =  0.05567
		    "v"  =  0.05567
		    "w"  =  0.05567
		    "x"  =  0.05567
		    "y"  =  0.05567
		    "z"  =  0.05567
		    "A"  =  0.05567
		    "B"  =  0.05567
		    "C"  =  0.05567
		    "D"  =  0.05567
		    "E"  =  0.05567
		    "F"  =  0.05567
		    "G"  =  0.05567
		    "H"  =  0.05567
		    "I"  =  0.05567
		    "J"  =  0.05567
		    "K"  =  0.05567
		    "L"  =  0.05567
		    "M"  =  0.05567
		    "N"  =  0.05567
		    "O"  =  0.05567
		    "P"  =  0.05567
		    "Q"  =  0.05567
		    "R"  =  0.05567
		    "S"  =  0.05567
		    "T"  =  0.05567
		    "U"  =  0.05567
		    "V"  =  0.05567
		    "W"  =  0.05567
		    "X"  =  0.05567
		    "Y"  =  0.05567
		    "Z"  =  0.05567
            " "  =  0.05567
		    "1"  =  0.05567
		    "2"  =  0.05567
		    "3"  =  0.05567
		    "4"  =  0.05567
		    "5"  =  0.05567
		    "6"  =  0.05567
		    "7"  =  0.05567
		    "8"  =  0.05567
		    "9"  =  0.05567
		    "0"  =  0.05567
		    "#"  =  0.05567
		    "$"  =  0.05567
		    "%"  =  0.05567
		    "^"  =  0.05567
		    '&'   =  0.05567
		    "*"  =  0.05567
		    "("  =  0.05567
		    ")"  =  0.05567
		    "+"  =  0.05567 
		    "="  =  0.05567
		    "<"  =  0.05567
		    ">"  =  0.05567
		    "?"  =  0.05567
		    "/"  =  0.05567
		    "\"  =  0.05567
		    "}"  =  0.05567
		    "{"  =  0.05567
		    "]"  =  0.05567
		    "["  =  0.05567
		    "."  =  0.05567
		    ","  =  0.05567
		    ";"  =  0.05567
		    ":"  =  0.05567
		    '"'  =  0.05567
		    "'"  =  0.05567
		    "-"  =  0.05567
		   other =  0.11700	
		;
		/*
		invalue __Table_US
		
		;
		
		invalue __Table_CN
		
		;
		*/
	run;
	
	%macro strToMvar(str,seperator=%str( ),prefix=lwd);
	 
		    %global &prefix.n;
		    %local temp i;
		    %let i = 1;
		    %let temp = %qscan(&str,1,&seperator);
		    %do %while ( &temp ne);
		            %global &prefix&i;
		            %let &prefix&i = &temp;
		            %put Macro variable &prefix&i = &&&prefix&i;
		            %let i = %eval(&i + 1);
		            %let temp = %qscan(&str,&i,&seperator);
		    %end;
		    %let &prefix.N = %eval(&i - 1);
		    %put Macro variable &prefix.N = &&&prefix.N;
	%mend;
	/*----------------------Temp variables in data step explanation--------------------- 
		   page    : The ultimate variable	
		   __lines : One obsevation in input dataset should occupy actual lines in RTF file.
		   __jj    : Equals to fraction of cell's value, when narrow than given width.
		   	     if wider, just caculate the residule.
			     exp:
			     	fraction = "Areyouok?", cell's capacity equals to 5 chars.how much residule?
				In the algorithm, residule will be assigned as width of  "uok?" occupyed.
		   __str   : Equals to fraction of cell's value.
	array colsWidth	   : The array stores actual lines of each variable.
		__aWidth   : Summation of fraction of cell's value. If bigger than given width, it will be set to residule. 
		__tempwidth: Summation of fraction of cell's value plus __width,for comparing to given width.
		__len      : The klength of the fraction of cell's value.
		__flag     : The cell's value fraction contain line break? if cell's value is "abd akhd@n ha", then "abd", "akhd@n"
				"ha" are called as fractions of cell's value here.
		__k        : Iteration number of whole value of the cell.
		__width    : The width of the fraction of cell's value.
		__ind      : The position of line break in the  the widdth of fraction wider than .
		__flag2    : When the fraction of cell's value wider than given width of cell, the flag will be assigned to 1.
		__dd1      : Serve for calculating  __jj, when  the widdth of fraction wider than given width. Same as above.
		__dd2      : Same as above.
		__lines    : Actual lines calculated.
		__S        : Summation of __lines variable. Comparing to maxrows in one page, generate page variable.
	
	*/
	%macro __lines(inds,outds,cols,colWidths);
		%strToMvar(&colWidths.,prefix=W);
		%strToMvar(&cols.,prefix=C);
		%strToMvar(&orderby.,prefix=oo);
		data &outds.;
			retain page __lines 1;
			length __jj __str $200.;
			set &inds.;
			*by &orderby.;
			__flag__0=1;
			%do __i=1 %to &oon.;
				__flag__&__i =0;
				__tmpColValue&__i. = &&oo&__i;  
				if __flag__%eval(&__i-1)  then  __flag__&__i = (&&oo&__i = lag1(&&oo&__i));
				if __flag__&__i then call missing(&&oo&__i);
			%end;

			array colsWidth(&wn.) ;
			%macro __inner;
			%do __i=1 %to &wn.;
				colsWidth[&__i.] = 0;
				__aWidth = 0;
				__tempwidth=0;
				__len=0;
				__flag= 0 ;
				__k = 1;
				__width = 0;
				__str = scan(&&C&__i,__k," ");
				*_alen can not be larger than &&w&i;
				*only filling plus one;
				do while(__str ne "");
					*must at end of _str;
					__flag = 0;
					__width = 0;
					__ind = kindex(__str,"@R/RTF'\line");
					if ^__ind then __ind = kindex(__str,"\line");
					if __ind then do;
							__len =__ind -1 ;
							__flag = 1;
					end;
					else
						__len = klength(__str);
					__flag2 = 0;
					__dd1 = 0;
					__dd2 = 0;
					do __tt =1 to __len;
						__charWdith  =	input(strip(ksubstr(__str,__tt,1)),&__style..);
						__width + __charWdith;
						__dd2 + __charWdith;
						if __dd2 > &&w&__i and __dd1 <= &&w&__i then do;
							__flag2 = 1;
							__dd1 = 0;
							__dd2 = __charWdith;
							__jj = strip(ksubstr(__str,__tt));
						end;
						__dd1 + __charWdith;
					end;
					if ^__flag2 then __jj = __str;
					if __awidth ^= 0  then 
						__tempWidth = __aWidth + __width + input(" ",&__style..);
					else 	
						__tempWidth = __width;
					if __tempWidth > &&w&__i then do;
						if __aWidth = 0 then do;
							colsWidth[&__i.] + floor( __width / &&w&__i);
							__aWidth =0;
							do __mm = 1 to length(__jj);
								__aWidth + input(strip(ksubstr(__jj,__mm,1)),&__style..);
							end;
							if __flag and __aWidth ^=0 then do;
									colsWidth[&__i.] + 1;
									__aWidth = 0;
							end;
						end;
						else if __aWidth < &&w&__i then do;
							colsWidth[&__i.] + floor( __width / &&w&__i) + 1;
							__aWidth =0;
							do __mm = 1 to length(__jj);
								__aWidth + input(strip(ksubstr(__jj,__mm,1)),&__style..);
							end;
							if __flag and __aWidth ^=0 then do;
									colsWidth[&__i.] + 1;
									__aWidth = 0;
							end;
						end;

					end;
					else if __tempWidth = &&w&__i then do;
							colsWidth[&__i.] + 1;
							__aWidth= 0;
					end;
					else do;
						__aWidth = __tempWidth;
						if __flag and __aWidth ^=0 then do;
									colsWidth[&__i.] + 1;
									__aWidth = 0;
						end;
					end;
					__k + 1;
					__str = scan(&&C&__i,__k," ");
				
				end;
				if __aWidth ^= 0  then colsWidth[&__i.] + 1;
			%end;
			__lines = max(of colsWidth[*]);
			%mend __inner;
			%__inner;
			retain __S 0;
			__S + __lines;
			if __S > &maxRows. then do;
				page + 1;
				*rewriting __lines;
				%do __i=1 %to &oon.;
					&&oo&__i= __tmpColValue&__i.;
				%end;
				%__inner;
				__S = __lines;
			end;
			%do __i=1 %to &oon.;
				&&oo&__i= __tmpColValue&__i.;
			%end;
		run;
	%mend;
	%strToMvar(&orderby.,prefix=oo);
	%__lines(&inds.,lwd1,&cols.,&colWidths.);

	data &outds.;
		retain page __lines 1;
		merge &inds.(in=a) lwd1(keep=page __:);
	run;
%mend; 
