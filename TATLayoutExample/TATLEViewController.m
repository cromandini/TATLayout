//
//  TATLEViewController.m
//  TATLayout
//

#import "TATLEViewController.h"
#import "TATLayout.h"

typedef NS_ENUM(NSUInteger, TATLayoutViewControllerExample) {
    TATLayoutViewControllerExampleConstraintFactory,
    TATLayoutViewControllerExampleViewConstraints,
    TATLayoutViewControllerExampleLayoutManager
};

#define TAT_LAYOUT_INIT_EXAMPLE TATLayoutViewControllerExampleLayoutManager

@interface TATLEViewController ()
@property (strong, nonatomic) UIImageView *albumArt;
@property (strong, nonatomic) UIImageView *progressBar;
@property (strong, nonatomic) UILabel *timeElapsed;
@property (strong, nonatomic) UILabel *timeRemaining;
@property (strong, nonatomic) UILabel *songTitle;
@property (strong, nonatomic) UILabel *albumTitle;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UISlider *volumeSlider;
@property (strong, nonatomic) UIButton *repeatButton;
@property (strong, nonatomic) UIButton *shuffleButton;
@property (strong, nonatomic) NSLayoutConstraint *phoneLandscapeConstraint;
@end

@implementation TATLEViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tintColor = [UIColor colorWithRed:0.988 green:0.192 blue:0.349 alpha:1.000];
    
    NSDictionary *metrics = @{@"progressHeight": @15,
                              @"playbackSpacing": @43,
                              @"playbackButtonSize": @44,
                              @"timeSpacing": @8,
                              @"longPadding": @20,
                              @"shortPadding": @10,
                              @"progressToVolumeSpacing": @31,
                              @"volumeMaxWidthPhone": @440,
                              @"volumeMultiplierPad": @(3.0 / 4),
                              @"highPriority": @751,
                              @"lowPriority": @251};
    
    NSDictionary *views = @{@"art": self.albumArt,
                            @"progress": self.progressBar,
                            @"timeElapsed": self.timeElapsed,
                            @"timeRemaining": self.timeRemaining,
                            @"songTitle" : self.songTitle,
                            @"albumTitle": self.albumTitle,
                            @"play": self.playButton,
                            @"prev": self.prevButton,
                            @"next": self.nextButton,
                            @"volume": self.volumeSlider,
                            @"repeat": self.repeatButton,
                            @"shuffle": self.shuffleButton};
    
    [self.albumArt addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"art.height == art.width"
                                                                              metrics:nil views:views]];
    [self.progressBar addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"progress.height == progressHeight"
                                                                                 metrics:metrics views:views]];
    for (UIButton *button in @[self.playButton, self.prevButton, self.nextButton]) {
        NSDictionary *bindings = NSDictionaryOfVariableBindings(button);
        [button addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"button.width == playbackButtonSize"
                                                                           metrics:metrics views:bindings]];
        [button addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"button.height == button.width"
                                                                           metrics:metrics views:bindings]];
    }
    
    NSArray *sharedFormats = @[@"art.top == superview.top @highPriority",
                               @"art.centerX == superview.centerX",
                               @"art.width == superview.width @252",
                               @"progress.leading == volume.leading + progressToVolumeSpacing",
                               @"progress.trailing == volume.trailing - progressToVolumeSpacing",
                               @"timeElapsed.centerY == progress.centerY",
                               @"timeElapsed.trailing == progress.leading - timeSpacing",
                               @"timeRemaining.centerY == progress.centerY",
                               @"timeRemaining.leading == progress.trailing + timeSpacing",
                               @"songTitle.leading == superview.leading + longPadding",
                               @"songTitle.trailing == superview.trailing - longPadding",
                               @"albumTitle.leading == superview.leading + longPadding",
                               @"albumTitle.trailing == superview.trailing - longPadding",
                               @"play.centerX == superview.centerX",
                               @"play.bottom == volume.top + 3",
                               @"prev.centerY == play.centerY",
                               @"prev.trailing == play.leading - playbackSpacing",
                               @"next.centerY == play.centerY",
                               @"next.leading == play.trailing + playbackSpacing",
                               @"volume.centerX == superview.centerX",
                               @"volume.leading >= superview.leading + longPadding @highPriority",
                               @"volume.trailing >= superview.trailing - longPadding @highPriority"];
    
    for (NSString *format in sharedFormats) {
        [self.view addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:metrics views:views]];
    }
    
    NSArray *deviceSpecificFormats;
    
    if (TATDeviceIsIPHONE) {
        deviceSpecificFormats = @[@"art.bottom <= progress.top - shortPadding @highPriority",
                                  @"progress.bottom == songTitle.top - 8",
                                  @"songTitle.bottom == albumTitle.top - 2",
                                  @"albumTitle.bottom == play.top - 9",
                                  @"volume.bottom == superview.bottom - 38",
                                  @"volume.width <= volumeMaxWidthPhone",
                                  @"repeat.leading == volume.leading - shortPadding",
                                  @"repeat.bottom == superview.bottom - 2",
                                  @"shuffle.trailing == volume.trailing + shortPadding",
                                  @"shuffle.bottom == repeat.bottom"];
    } else {
        deviceSpecificFormats = @[
                                  @"songTitle.top == superview.top + 16",
                                  @"albumTitle.top == songTitle.bottom + 4",
                                  @"art.top == albumTitle.bottom + shortPadding",
                                  @"art.bottom <= progress.top - 16",
                                  @"progress.bottom == play.top - 12",
                                  @"volume.width <= art.width * volumeMultiplierPad",
                                  @"volume.centerY == repeat.centerY",
                                  @"repeat.leading == art.leading @lowPriority",
                                  @"repeat.leading >= superview.leading + longPadding",
                                  @"repeat.bottom == superview.bottom - shortPadding",
                                  @"shuffle.trailing == art.trailing @lowPriority",
                                  @"shuffle.trailing <= superview.trailing - longPadding",
                                  @"shuffle.centerY == repeat.centerY"];
    }
    
    for (NSString *format in deviceSpecificFormats) {
        [self.view addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:metrics views:views]];
    }
}

- (void)viewWillLayoutSubviews
{
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
        self.songTitle.font = [UIFont boldSystemFontOfSize:18];
        self.albumTitle.font = [UIFont systemFontOfSize:13];
        if (TATDeviceIsIPHONE) {
            [self.view addConstraint:self.phoneLandscapeConstraint];
        }
    } else {
        self.songTitle.font = [UIFont boldSystemFontOfSize:20];
        self.albumTitle.font = [UIFont systemFontOfSize:14];
        if (TATDeviceIsIPHONE) {
            [self.view removeConstraint:self.phoneLandscapeConstraint];
        }
    }
}

#pragma mark - Dynamic Constraints

- (NSLayoutConstraint *)phoneLandscapeConstraint
{
    if (!_phoneLandscapeConstraint) {
        NSDictionary *views = @{@"art": self.albumArt};
        _phoneLandscapeConstraint = [NSLayoutConstraint tat_constraintWithEquationFormat:@"art.top == superview.top + 14"
                                                                                 metrics:nil views:views];
    }
    return _phoneLandscapeConstraint;
}

#pragma mark - UI Elements

- (UIImageView *)albumArt
{
    if (!_albumArt) {
        _albumArt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumArt"]];
        [_albumArt setContentMode:UIViewContentModeScaleAspectFit];
        _albumArt.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_albumArt];
    }
    return _albumArt;
}

- (UIImageView *)progressBar
{
    if (!_progressBar) {
        _progressBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProgressBar"]];
        [_progressBar setContentMode:UIViewContentModeScaleToFill];
        _progressBar.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_progressBar];
    }
    return _progressBar;
}

- (UILabel *)timeElapsed
{
    if (!_timeElapsed) {
        _timeElapsed = [self timeLabelWithText:@"0:00"];
        _timeElapsed.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_timeElapsed];
    }
    return _timeElapsed;
}

- (UILabel *)timeRemaining
{
    if (!_timeRemaining) {
        _timeRemaining = [self timeLabelWithText:@"-3:29"];
        _timeRemaining.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_timeRemaining];
    }
    return _timeRemaining;
}

- (UILabel *)timeLabelWithText:(NSString *)text
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.text = text;
    return label;
}

- (UILabel *)songTitle
{
    if (!_songTitle) {
        _songTitle = [UILabel new];
        _songTitle.text = @"The Gentle Art of Making Enemies";
        _songTitle.textAlignment = NSTextAlignmentCenter;
        [_songTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _songTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_songTitle];
    }
    return _songTitle;
}

- (UILabel *)albumTitle
{
    if (!_albumTitle) {
        _albumTitle = [UILabel new];
        _albumTitle.text = @"Faith No More – King for a Day, Fool for a Lifetime";
        _albumTitle.textAlignment = NSTextAlignmentCenter;
        [_albumTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _albumTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_albumTitle];
    }
    return _albumTitle;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
        _playButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_playButton];
    }
    return _playButton;
}

- (UIButton *)prevButton
{
    if (!_prevButton) {
        _prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_prevButton setBackgroundImage:[UIImage imageNamed:@"prevButton"] forState:UIControlStateNormal];
        _prevButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_prevButton];
    }
    return _prevButton;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"nextButton"] forState:UIControlStateNormal];
        _nextButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}

- (UISlider *)volumeSlider
{
    if (!_volumeSlider) {
        _volumeSlider = [UISlider new];
        _volumeSlider.value = 0.95;
        _volumeSlider.minimumValueImage = [UIImage imageNamed:@"minVolume"];
        _volumeSlider.maximumValueImage = [UIImage imageNamed:@"maxVolume"];
        [_volumeSlider setThumbImage:[UIImage imageNamed:@"volumeThumb"] forState:UIControlStateNormal];
        _volumeSlider.minimumTrackTintColor = [UIColor blackColor];
        [_volumeSlider setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _volumeSlider.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_volumeSlider];
    }
    return _volumeSlider;
}

- (UIButton *)repeatButton
{
    if (!_repeatButton) {
        _repeatButton = [self modeButtonWithTitle:@"Repeat"];
        _repeatButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_repeatButton];
    }
    return _repeatButton;
}

- (UIButton *)shuffleButton
{
    if (!_shuffleButton) {
        _shuffleButton = [self modeButtonWithTitle:@"Shuffle"];
        _shuffleButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_shuffleButton];
    }
    return _shuffleButton;
}

#pragma mark - Helpers

- (UIButton *)modeButtonWithTitle:(NSString *)title
{
    UIButton *modeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    modeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [modeButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [modeButton setTitle:title forState:UIControlStateNormal];
    return modeButton;
}

@end
