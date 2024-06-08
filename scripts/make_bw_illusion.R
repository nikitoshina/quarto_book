library(imager)

# Function to generate 1/f^beta noise
generate_1f_noise <- function(dim, beta, reverse = FALSE) {
  # Create a grid of frequencies
  freq <- expand.grid(x = 1:dim[1], y = 1:dim[2])
  freq$x <- ifelse(freq$x - 1 > dim[1]/2, freq$x - 1 - dim[1], freq$x - 1)
  freq$y <- ifelse(freq$y - 1 > dim[2]/2, freq$y - 1 - dim[2], freq$y - 1)
  
  # Compute frequency magnitudes
  magnitude <- sqrt(freq$x^2 + freq$y^2)
  magnitude[magnitude == 0] <- 1  # Avoid division by zero at the DC component
  
  # Compute power spectrum
  spectrum <- 1 / (magnitude^beta)
  
  # Generate random phases
  phases <- runif(nrow(freq), min = -pi, max = pi)
  
  # Create complex numbers from spectrum and phase
  complex_field <- spectrum * (cos(phases) + 1i * sin(phases))
  complex_image <- matrix(complex_field, nrow = dim[1], ncol = dim[2], byrow = TRUE)
  
  # Perform inverse FFT and scale to [0,1]
  image <- fft(complex_image, inverse = TRUE) / (dim[1]*dim[2])
  image <- Re(image)
  image <- (image - min(image)) / (max(image) - min(image))
  
  if (reverse) {
    image <- 1 - image
  }
  library(imager)
  
  # Function to generate 1/f^beta noise
  generate_1f_noise <- function(dim, beta) {
    freq <- expand.grid(x = 1:dim[1], y = 1:dim[2])
    freq$x <- ifelse(freq$x - 1 > dim[1]/2, freq$x - 1 - dim[1], freq$x - 1)
    freq$y <- ifelse(freq$y - 1 > dim[2]/2, freq$y - 1 - dim[2], freq$y - 1)
    
    magnitude <- sqrt(freq$x^2 + freq$y^2)
    magnitude[magnitude == 0] <- 1  # Avoid division by zero at the DC component
    spectrum <- 1 / (magnitude^beta)
    phases <- runif(nrow(freq), min = -pi, max = pi)
    complex_field <- spectrum * (cos(phases) + 1i * sin(phases))
    complex_image <- matrix(complex_field, nrow = dim[1], ncol = dim[2], byrow = TRUE)
    
    image <- fft(complex_image, inverse = TRUE) / (dim[1]*dim[2])
    image <- Re(image)
    image <- (image - min(image)) / (max(image) - min(image))
    
    return(image)
  }
  
  # Apply a high-pass filter to enhance edges
  enhance_edges <- function(image, threshold = 0.5) {
    # Apply a threshold to create sharper edges
    image[image < threshold] <- 0
    image[image >= threshold] <- 1
    return(image)
  }
  
  # Generate noise image
  set.seed(123)
  noise_image <- generate_1f_noise(dim = c(512, 512), beta = 4)
  processed_image <- enhance_edges(noise_image, threshold = 0.5)
  
  # Plot the processed image
  plot(as.cimg(processed_image), main = "Enhanced Edge Harshness")
  
  
  return(image)
}

# Generate and plot 1/f^4 noise
set.seed(228)
noise_image <- generate_1f_noise(dim = c(512, 512), beta = 4, reverse =TRUE)

# Convert to cimg object before plotting
noise_cimg <- as.cimg(noise_image)
plot(noise_cimg, main = "1/f^4 Noise with Reversed Colors")

# Save the image
# save.image(noise_cimg, "../reversed_noise_image.png")

