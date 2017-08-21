function [] = publishpic(fig_handle,varargin)
% PUBLISHPIC Redoes the spacing and axis of a figure to appear more
    % presentable. Assumes that the axes are present in the figure
    % PUBLISHPIC() grabs the current figure and applies the default spacing,
    % axis and page parameters.
    % PUBLISHPIC(fig_handle) applies the default parameters to fig_handle.
    % PUBLISHPIC(fig_handle, ... Param1, Value1, ... etc.) changes the spacing,
    % axis and page parameters of fig_handle according to Param1, Param2,
    % etc... with values Value1, Value2, etc...
    % The following are the possible parameters:
    % Page_Width: Width of the printed page.
    % Page_Height: Height of the printed page.
    % Left_Space: Left margin, from the figure edge to the edge of the first
    % axis.
    % Right_Space: Right margin, from the figure edge to the edge of the last
    % axis.
    % Top_Space: Top margin, from the figure top edge to the top of the upper
    % most axis.
    % Bot_Space: Bottom margin, from the figure bottom to the bottom edge of
    % the lowest axis.
    % Inner_W_Space: The horizontal spacing between axes.
    % Inner_H_Space: The vertical spacing between axes.
    %
    % This function assumes that the figure has sub axes within it. There is a
    % known issue if you use this function then clear the figure (clf) and try
    % to apply it again. Please close the figure and open it again.
    % If a parameter is not specified it uses the default value. The page size
    % defaults to 11x8.5 inches, and all spaces defaults to 0.8 inches.
    %
    % See also subplot, figure

%% Parse the inputs
% Check if figure is provided.
if nargin==0
    fig_handle=gcf;
end
% Parse varargin
inputs=inputParser;
defaultW=11;
defaultH=8.5;
defaultleftsp=0.8/defaultW;
defaultrightsp=0.8/defaultW;
defaulttopsp=0.8/defaultH;
defaultbotsp=0.8/defaultH;
defaultinwsp=0.8/defaultW;
defaultinhsp=0.8/defaultH;
addParameter(inputs,'Page_Width',defaultW);
addParameter(inputs,'Page_Height',defaultH);
addParameter(inputs,'Left_Space',defaultleftsp);
addParameter(inputs,'Right_Space',defaultrightsp);
addParameter(inputs,'Top_Space',defaulttopsp);
addParameter(inputs,'Bot_Space',defaultbotsp);
addParameter(inputs,'Inner_W_Space',defaultinwsp);
addParameter(inputs,'Inner_H_Space',defaultinhsp);
parse(inputs,varargin{:});
W=inputs.Results.Page_Width;
H=inputs.Results.Page_Height;
right_sp=inputs.Results.Right_Space;
left_sp=inputs.Results.Left_Space;
bot_sp=inputs.Results.Bot_Space;
top_sp=inputs.Results.Top_Space;
inner_w_sp=inputs.Results.Inner_W_Space;
inner_h_sp=inputs.Results.Inner_H_Space;

%% Set page options
fig_handle.Units='normalized';
fig_handle.PaperUnits='inches';
fig_handle.PaperSize=[W H];
fig_handle.OuterPosition= [0.25 0.5 0.5 0.5];
fig_handle.PaperPosition=[0 0 W H];

%% Calculate correct positions
% Sort the axis to be in top-left to bottom-right order.
[original_positions,axes]=sort_axes(findobj(fig_handle,'Type','Axes'));
num_ax=length(axes);
if num_ax == 0
    error('No axis within input figure')
elseif num_ax ==1
    %%
    % If there is only one axis, performed simplified calculation and set
    % parameters.
    final_width=1-left_sp-right_sp;
    final_height=1-bot_sp-top_sp;
    cur_ax=axes;
    cur_ax.Units='normalized';
    cur_ax.Position=[left_sp bot_sp final_width final_height];
    cur_ax.FontWeight='bold';
    cur_ax.FontSize=12;
    setappdata(fig_handle,'SubplotGrid',zeros(1,1));
else
    %%
    % Check SubplotGrid.
    [m,n]=size(getappdata(fig_handle,'SubplotGrid'));
    if (m==0) || (n==0)
        error('No SubplotGrid detected')
    end
    %%
    % Calculate horizontal positions.
    by_left=sortrows(original_positions,1);
    left_margin=by_left(1,1);
    right_margin=1-(by_left(end,1)+by_left(end,3));
    for ii=1:length(by_left)
        if n==1
            inner_w_spacing=0;
            break
        elseif (~(by_left(ii+1,1)-by_left(ii,1)==0))
            inner_w_spacing_vec=-(by_left(1:ii,1)+by_left(1:ii,3))+by_left(ii+1,1);
            inner_w_spacing=max(inner_w_spacing_vec);
            break
        end
    end
    %%
    % Calculate vertical positions.
    by_bot=sortrows(original_positions,2);
    bot_margin=by_bot(1,2);
    top_margin=1-(by_bot(end,2)+by_bot(end,4));
    for ii=1:length(by_bot)
        if m==1
            inner_h_spacing=0;
            break
        elseif (~(by_bot(ii+1,2)-by_bot(ii,2)==0))
            inner_h_spacing=-(by_bot(1:ii,2)+by_bot(1:ii,4))+by_bot(ii+1,2);
            inner_h_spacing=max(inner_h_spacing);
            break
        end
    end
    base_width=(1-right_margin-left_margin-(n-1)*inner_w_spacing)/n;
    base_height=(1-bot_margin-top_margin-(m-1)*inner_h_spacing)/m;
    %%
    % Calculate relative size of subplots compared to base grid.
    axes_multipliers=zeros(num_ax,2);
    axes_grid_pos=zeros(num_ax,2);
    for jj=1:num_ax
        for ii=n:-1:1
            if round(original_positions(jj,3),5)==round(ii*base_width+(ii-1)*inner_w_spacing,5)
                axes_multipliers(jj,1)=ii;
            end
            if round(original_positions(jj,1),5)==round(left_margin+(ii-1)*(inner_w_spacing+base_width),5)
                axes_grid_pos(jj,1)=ii;
            end
        end
        for ii=m:-1:1
            if round(original_positions(jj,4),5)==round(ii*base_height+(ii-1)*inner_h_spacing,5)
                axes_multipliers(jj,2)=ii;
            end
            if round(original_positions(jj,2),5)==round(bot_margin+(ii-1)*(inner_h_spacing+base_height),5)
                axes_grid_pos(jj,2)=ii;
            end
        end
    end
    %%
    % Calculate the final posititions for new grid.
    final_width=(1-left_sp-right_sp-(n-1)*inner_w_sp)/n;
    final_height=(1-bot_sp-top_sp-(m-1)*inner_h_sp)/m;
    
    %% Place the various subplots
    for ii=1:num_ax
        %%
        % Place the subaxis and change the font.
        cur_ax=axes(ii);
        cur_ax.Units='normalized';
        cur_ax.Position=[left_sp+(axes_grid_pos(ii,1)-1)*(inner_w_sp+final_width) ...
            bot_sp+(axes_grid_pos(ii,2)-1)*(inner_h_sp+final_height) ...
            axes_multipliers(ii,1)*final_width+(axes_multipliers(ii,1)-1)*inner_w_sp ...
            axes_multipliers(ii,2)*final_height+(axes_multipliers(ii,2)-1)*inner_h_sp];
        cur_ax.FontWeight='bold';
        cur_ax.FontSize=12;
    end
    %%
    % Set the appdata on the figure. Provides the information if function
    % is run again. NOTE: for some reason clf does not clear this property
    % and will cause errors if you run this function after it.
    setappdata(fig_handle,'SubplotGrid',zeros(m,n));
end

end

function [sorted_positions, sorted_axes]=sort_axes(array_of_axes)
% SORT_AXES sorts the axis from top-left to bottom-right.
    % [POSITIONS,AXES] = sort_axes(array_of_axes) Takes in an array of subplot axes
    % and sorts them from top-left to bottom right according to their position.
    % This returns POSITIONS which is a matrix that contains the position
    % vectors of the sorted axes. AXES is the array of sorted axes.
num_axes=length(array_of_axes);
positions=zeros(num_axes,4);
for ii=1:num_axes
    positions(ii,:)=array_of_axes(ii).Position;
end
[sorted_positions,sort_index]=sortrows(positions,[-2 1]);
sorted_axes=array_of_axes(sort_index);
end