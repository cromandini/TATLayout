//
//  TATLayoutExampleViewController.m
//  TATLayoutExample
//

#import "TATLayoutExampleViewController.h"
#import "TATLayout.h"

#define TATLayoutExampleDeviceIsIPHONE [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone

@interface TATLayoutExampleViewController ()
@property (strong, nonatomic) UILabel *songTitle;
@property (strong, nonatomic) UILabel *albumTitle;
@property (strong, nonatomic) UIImageView *albumArt;
@property (strong, nonatomic) NSLayoutConstraint *iPhoneLandscapeConstraint;
@end

@implementation TATLayoutExampleViewController

#pragma mark - Lifecycle

- (void)loadView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.tintColor = [UIColor colorWithRed:0.988 green:0.192 blue:0.349 alpha:1.000];
    
    UIImageView *albumArt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumArt"]];
    [albumArt setContentMode:UIViewContentModeScaleAspectFit];
    
    UIImageView *progressBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProgressBar"]];
    [progressBar setContentMode:UIViewContentModeScaleToFill];
    
    UILabel *timeElapsed = [UILabel new];
    timeElapsed.font = [UIFont systemFontOfSize:10];
    timeElapsed.text = @"0:00";

    UILabel *timeRemaining = [UILabel new];
    timeRemaining.font = [UIFont systemFontOfSize:10];
    timeRemaining.text = @"-3:29";
    
    UILabel *songTitle = [UILabel new];
    songTitle.text = @"The Gentle Art of Making Enemies";
    songTitle.textAlignment = NSTextAlignmentCenter;
    [songTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UILabel *albumTitle = [UILabel new];
    albumTitle.text = @"Faith No More – King for a Day, Fool for a Lifetime";
    albumTitle.textAlignment = NSTextAlignmentCenter;
    [albumTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    
    UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [prevButton setBackgroundImage:[UIImage imageNamed:@"prevButton"] forState:UIControlStateNormal];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"nextButton"] forState:UIControlStateNormal];
    
    UISlider *volumeSlider = [UISlider new];
    volumeSlider.minimumValueImage = [UIImage imageNamed:@"minVolume"];
    volumeSlider.maximumValueImage = [UIImage imageNamed:@"maxVolume"];
    [volumeSlider setThumbImage:[UIImage imageNamed:@"volumeThumb"] forState:UIControlStateNormal];
    volumeSlider.minimumTrackTintColor = [UIColor blackColor];
    volumeSlider.value = 0.95;
    [volumeSlider setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UIButton *repeatButton = [UIButton buttonWithType:UIButtonTypeSystem];
    repeatButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [repeatButton setTitle:@"Repeat" forState:UIControlStateNormal];
    [repeatButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UIButton *shuffleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shuffleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [shuffleButton setTitle:@"Shuffle" forState:UIControlStateNormal];
    [shuffleButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(albumArt,
                                                         progressBar,
                                                         timeElapsed,
                                                         timeRemaining,
                                                         songTitle,
                                                         albumTitle,
                                                         playButton,
                                                         prevButton,
                                                         nextButton,
                                                         volumeSlider,
                                                         repeatButton,
                                                         shuffleButton);
    
    [views enumerateKeysAndObjectsUsingBlock:^(id key, UIView *subview, BOOL *stop) {
        [view addSubview:subview];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }];
    
    NSDictionary *metrics = @{@"playbackSpacing": @43,
                              @"playbackButtonsSize": @44,
                              @"timeSpacing": @8,
                              @"shortPadding": @10,
                              @"longPadding": @20,
                              @"progressToVolumeSpacing": @31,
                              @"volumeMultiplier": @(3.0 / 4),
                              @"highPriority": @751,
                              @"lowPriority": @251};
    
    NSArray *formats = @[@"albumArt.height       == albumArt.width",
                         @"albumArt.top          == superview.top @highPriority",
                         @"albumArt.centerX      == superview.centerX",
                         @"albumArt.width        == superview.width @252",
                         @"progressBar.height    == 15",
                         @"progressBar.leading   == volumeSlider.leading + progressToVolumeSpacing",
                         @"progressBar.trailing  == volumeSlider.trailing - progressToVolumeSpacing",
                         @"timeElapsed.centerY   == progressBar.centerY",
                         @"timeElapsed.trailing  == progressBar.leading - timeSpacing",
                         @"timeRemaining.centerY == progressBar.centerY",
                         @"timeRemaining.leading == progressBar.trailing + timeSpacing",
                         @"songTitle.leading     == superview.leading + longPadding",
                         @"songTitle.trailing    == superview.trailing - longPadding",
                         @"albumTitle.leading    == superview.leading + longPadding",
                         @"albumTitle.trailing   == superview.trailing - longPadding",
                         @"playButton.width      == playbackButtonsSize",
                         @"playButton.height     == playbackButtonsSize",
                         @"playButton.centerX    == superview.centerX",
                         @"playButton.bottom     == volumeSlider.top + 3",
                         @"prevButton.width      == playbackButtonsSize",
                         @"prevButton.height     == playbackButtonsSize",
                         @"prevButton.centerY    == playButton.centerY",
                         @"prevButton.trailing   == playButton.leading - playbackSpacing",
                         @"nextButton.width      == playbackButtonsSize",
                         @"nextButton.height     == playbackButtonsSize",
                         @"nextButton.centerY    == playButton.centerY",
                         @"nextButton.leading    == playButton.trailing + playbackSpacing",
                         @"volumeSlider.centerX  == superview.centerX",
                         @"volumeSlider.leading  >= superview.leading + longPadding @highPriority",
                         @"volumeSlider.trailing >= superview.trailing - longPadding @highPriority"];
    [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
    
    if (TATLayoutExampleDeviceIsIPHONE) {
        formats = @[@"albumArt.bottom        <= progressBar.top - shortPadding @highPriority",
                    @"progressBar.bottom     == songTitle.top - 8",
                    @"songTitle.bottom       == albumTitle.top - 2",
                    @"albumTitle.bottom      == playButton.top - 9",
                    @"volumeSlider.bottom    == superview.bottom - 38",
                    @"volumeSlider.width     <= 440",
                    @"repeatButton.leading   == volumeSlider.leading - shortPadding",
                    @"repeatButton.bottom    == superview.bottom - 2",
                    @"shuffleButton.trailing == volumeSlider.trailing + shortPadding",
                    @"shuffleButton.bottom   == repeatButton.bottom"];
    } else {
        formats = @[@"songTitle.top          == superview.top + 16",
                    @"albumTitle.top         == songTitle.bottom + 4",
                    @"albumArt.top           == albumTitle.bottom + shortPadding",
                    @"albumArt.bottom        <= progressBar.top - 16",
                    @"progressBar.bottom     == playButton.top - 12",
                    @"volumeSlider.width     <= albumArt.width * volumeMultiplier",
                    @"volumeSlider.centerY   == repeatButton.centerY",
                    @"repeatButton.leading   == albumArt.leading @lowPriority",
                    @"repeatButton.leading   >= superview.leading + longPadding",
                    @"repeatButton.bottom    == superview.bottom - shortPadding",
                    @"shuffleButton.trailing == albumArt.trailing @lowPriority",
                    @"shuffleButton.trailing <= superview.trailing - longPadding",
                    @"shuffleButton.centerY  == repeatButton.centerY"];
    }
    [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
    
    self.songTitle = songTitle;
    self.albumTitle = albumTitle;
    self.albumArt = albumArt;
    self.view = view;
}

- (void)viewWillLayoutSubviews
{
    if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        self.songTitle.font = [UIFont boldSystemFontOfSize:18];
        self.albumTitle.font = [UIFont systemFontOfSize:13];
        if (TATLayoutExampleDeviceIsIPHONE) {
            [self.iPhoneLandscapeConstraint tat_install];
        }
    } else {
        self.songTitle.font = [UIFont boldSystemFontOfSize:20];
        self.albumTitle.font = [UIFont systemFontOfSize:14];
        if (TATLayoutExampleDeviceIsIPHONE) {
            [self.iPhoneLandscapeConstraint tat_uninstall];
        }
    }
}

#pragma mark - Dynamic Constraint

- (NSLayoutConstraint *)iPhoneLandscapeConstraint
{
    if (!_iPhoneLandscapeConstraint) {
        NSString *format = @"art.top == superview.top + 14";
        NSDictionary *views = @{@"art": self.albumArt};
        _iPhoneLandscapeConstraint = [NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:nil views:views];
    }
    return _iPhoneLandscapeConstraint;
}

@end
