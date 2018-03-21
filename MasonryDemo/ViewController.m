//
//  ViewController.m
//  MasonryDemo
//
//  Created by Ankit Jayaswal on 21/03/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

#import "ViewController.h"
#import "DynamicGalleryView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DynamicGalleryView *dynamicGalleryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *imagesArray = @[
                             @"https://ia.media-imdb.com/images/M/MV5BZTQzNmEwZTMtZGNkNC00YjQ5LThhYzMtZTBhNzUzODI5ZjRjXkEyXkFqcGdeQXVyMjM5NzU3OTM@._V1_QL50_SY1000_SX800_AL_.jpg",
                             @"https://ia.media-imdb.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_QL50_SY1000_CR0,0,641,1000_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BMGFkNWI4MTMtNGQ0OC00MWVmLTk3MTktOGYxN2Y2YWVkZWE2XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SY1000_CR0,0,639,1000_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_UX182_CR0,0,182,268_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BOTQ5NDI3MTI4MF5BMl5BanBnXkFtZTgwNDQ4ODE5MDE@._V1_SY1000_CR0,0,656,1000_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BYmViY2M2MTYtY2MzOS00YjQ1LWIzYmEtOTBiNjhlMGM0NjZjXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SY1000_CR0,0,644,1000_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BMjI2MTQwNDI3Nl5BMl5BanBnXkFtZTcwNDk4MTkzNA@@._V1_SY1000_CR0,0,666,1000_AL_.jpg",
                             @"https://images-na.ssl-images-amazon.com/images/M/MV5BYWY5ZjhjNGYtZmI2Ny00ODM0LWFkNzgtZmI1YzA2N2MxMzA0XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SY1000_CR0,0,693,1000_AL_.jpg"];
    
    [_dynamicGalleryView setArrayImageURL:imagesArray.mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
