# **Dracula Function Documentation**

### `draculize`
Applies the Dracula color theme to the current figure

#### OPTIONAL NAME-VALUE PAIRS

  * `AxesOnly` **::** Apply theme to the axes only {`false` (default) | `true`}
 
#### EXAMPLES
 ```matlab
 % Create a simple plot
  x = 1:10;
  y = 1:10;
  plot(x,y)
  draculize
 
 % Create a more complex plot
  [X,Y,Z] = peaks;
  contour3(X,Y,Z,20)
  title('3D Contour Plot')
  subtitle('Works with subtitles, too.')
  xlabel('X-axis'), ylabel('Y-axis'), zlabel('Z-axis')
  hold on
   text(-3.5,-2.5,-2.5,'...and added text!')
  hold off
  draculize(AxesOnly=true)
 ```
 
#### LIMITATIONS

  The `draculize` function works for most plotting functions, but not all. This is because there are a lot of less-common plot types that, unfortunately, are not very customizable. The draculize function is also not recommended for subplots or figures with secondary axes.

**See also**
[`dracula_colororder`](#dracula_colororder) [`dracula_colormap`](#dracula_colormap)

---

### `dracula_colororder`
Applies the Dracula color order to the current figure

#### OPTIONAL NAME-VALUE PAIRS

  * `Style` **::** Sets the order of the colors {`"classic"` (default) | `"distinct"` | `"rainbow"`}

  * `N` **::** The number of colors {must be between `1` and `7`}

  * `Order` **::** Choose to flip the order of the colors {`"normal"` (default) | `"reverse"`}

#### EXAMPLES
```matlab
 % Example 1
  x = linspace(0,10)';
  Y = ones(length(x),7).*(x.^0.67)+[6 5 4 3 2 1 0];
  plot(x,Y)
  dracula_colororder
 
 % Example 2
  plot(x,Y)
  dracula_colororder(Style='rainbow',Order='reverse')
```

**See also**
[`draculize`](#draculize) [`dracula_colormap`](#dracula_colormap)

---

### `dracula_colormap`
Applies the Dracula color map to the current figure

#### OPTIONAL NAME-VALUE PAIRS

  * `Order` **::** Choose to flip the order of the colors {`"normal"` (default) | `"reverse"`}

#### EXAMPLES
```matlab
 % Example 1
  surf(membrane)
  dracula_colormap
 
 % Example 2
  surf(membrane)
  dracula_colormap(Order='reverse')
```

**See also**
[`draculize`](#draculize) [`dracula_colororder`](#dracula_colororder)