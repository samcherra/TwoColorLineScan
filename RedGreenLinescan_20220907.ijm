// This macro will create a line scan from a stack of at least two images.
// The macro assumes the line of interest is drawn on stack 2.
// In our case the first image is the green channel, and the second is the red channel.

// Press 'm' to start macro

macro "Draw line [a]" {
	//clear log and results
	print("\\Clear");
	run("Clear Results");
	run("Set Measurements...", "area mean center redirect=None decimal=3");

	//print instructions for user
	print("Adjust contrast and focus on synapses.");
	print("Draw line along puncta that are in focus.");
	print("Double-click to end the line.");
	print("Then press 'b'.");
	
	//select segmented line tool
	setTool("polyline");
	
	//set line width to 10 pixels
	run("Line Width...", "line=10");
	
	//open brightness and contrast window
	run("Brightness/Contrast...");
}

macro "Plot profile [b]" {

	print("\\Clear")
	window_name = getTitle();

	//Plot profile from red channel
	run("Plot Profile");
	Plot.setStyle(0, "red,none,1.0,Line");
	rename("red_plot");
	selectWindow(window_name);
	run("Previous Slice [<]");

	//print instructions for user
	print("Press 'c' to plot profile from green channel.");
	
}

macro "Plot green profile [c]" {

	print("\\Clear")
	//Plot profile from green channel
	run("Plot Profile");
	Plot.setStyle(0, "green,none,1.0,Line");
	window_name2 = getTitle();
	rename("combined_plot");

	//Add plot of red channel to green channel plot
	selectWindow("combined_plot");
	Plot.addFromPlot("red_plot", 0);
	Plot.setStyle(1, "red,none,1.0,Line");
	Plot.setLimitsToFit();
	Plot.setFormatFlags("11000000000011");

	//print instructions for user
	print("Draw line to close regions of green graph that align");
	print("with red graph. Press ctrl+D to draw line.");
	print("Select wand tool. Click in each region.");
	print("Press m to measure.");
	print("Copy and paste Results window to Excel.");
	print("Click List->File->Save As to save profile plots as .csv file.");
	print("Press 'd' to close all windows.");
	
	//set line width to 2 pixels and choose black fill for line
	run("Line Width...", "line=2");
	setForegroundColor(4, 4, 4);
}

macro "Close all windows [d]" {
	print("\\Clear")
	run("Close All");
}

// Click List button. 
// Copy Plot Values to Excel. 
// Save as comma-separated value (.csv) file.