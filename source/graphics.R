library(RColorBrewer); library(ggpubr)
source('./source/functions.R')

theme_opts <- list(theme(axis.ticks.length=unit(-0.1, "cm"),  
                         axis.text.x = element_text(margin=unit(c(0.2,0.2,0.2,0.2), "cm")), 
                         axis.text.y = element_text(margin=unit(c(0.2,0.2,0.2,0.2), "cm"))))

period_cols <-  c("#97B8C2", "#BF9A77", "#D35C37")  
var_cols <- c("#336B87", "#90AFC5", "#BF9A77", "#D13525", "#F2C057")
alpha_cols <- melt(col2rgb(var_cols[1:3]))$value
col1 <- rgb(alpha_cols[1], alpha_cols[2], alpha_cols[3], 210, maxColorValue = 255)
col2 <- rgb(alpha_cols[4], alpha_cols[5], alpha_cols[6], 150, maxColorValue = 255)
col3 <- rgb(alpha_cols[7], alpha_cols[8], alpha_cols[9], 150, maxColorValue = 255)
var_cols_alpha <- c(col1, col2, col3)

colset_mid <- c( "#4D648D", "#337BAE", "#97B8C2",  "#739F3D", "#ACBD78",  
                 "#F4CC70", "#EBB582",  "#BF9A77",
                 "#E38B75", "#CE5A57",  "#D24136", "#785A46" )
colset_mid_qual <- colset_mid[c(11, 2, 4, 6,  1, 8, 10, 5, 7, 3, 9, 12)]
palette_mid <- colorRampPalette(colset_mid)
palette_mid_qual <- colorRampPalette(colset_mid_qual)
palette_spectral <- colorRampPalette(rev(brewer.pal(11, "Spectral")), space = "Lab")


plot_events_time <- function(dt){
  ggplot(dt, aes(x = yr, y = area)) + 
  geom_point(size = 2) + 
  geom_segment(aes(x = yr, 
                   xend = yr, 
                   y = 0, 
                   yend = area)) + 
  xlab('Time (years)') + 
  ylab('Number of grid cells') + 
  theme_bw() +
  theme_opts + 
  scale_y_continuous(expand = c(0, 0))} 

plot_var_dens_yr <- function(dt){
  ggplot(dt, aes(x = value, fill = variable, group = variable)) +
  geom_density(alpha = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 0.3, col = var_cols[1]) + 
  xlim(-3, 3) +
  scale_fill_manual(values = var_cols[c(1, 5, 4, 3, 2)]) +
  facet_wrap(vars(month)) +
  theme_bw() + 
  theme(strip.background = element_rect(fill = var_cols[1])) +
  theme(strip.text = element_text(colour = 'white')) + 
  theme_opts
}

plot_var_dens_prv <- function(dt){
  ggplot(dt, aes(x = value, fill = variable, group = variable)) +
    geom_density(alpha = 0.8) +
    geom_vline(xintercept = 0, linetype = "dashed", size = 0.3, col = var_cols[1]) + 
    xlim(-3, 3) +
    scale_fill_manual(values = var_cols[c(1, 5, 4, 3, 2)]) +
    facet_wrap(vars(time)) +
    theme_bw() + 
    theme(strip.background = element_rect(fill = var_cols[1])) +
    theme(strip.text = element_text(colour = 'white')) + 
    theme_opts
}

plot_var_dens_nxt <- function(dt){
  dt[, time_f := (paste0('+', as.character(time)))]
  ggplot(dt, aes(x = value, fill = variable, group = variable)) +
    geom_density(alpha = 0.8) +
    geom_vline(xintercept = 0, linetype = "dashed", size = 0.3, col = var_cols[1]) + 
    xlim(-3, 3) +
    scale_fill_manual(values = var_cols[c(1, 5, 4, 3, 2)]) +
    facet_wrap(vars(time_f)) +
    theme_bw() + 
    theme(strip.background = element_rect(fill = var_cols[1])) +
    theme(strip.text = element_text(colour = 'white')) + 
    theme_opts
}
