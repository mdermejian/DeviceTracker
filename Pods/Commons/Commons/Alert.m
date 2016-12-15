//
//  FSGAlert.m
//  Commons
//
//  Created by Marc Dermejian on 02/02/2015.
//

#import "Alert.h"

void AlertWithError(NSError *error)
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Error! %@ %@", @"Alert title for error message"),
                         [error localizedDescription],
                         [error localizedFailureReason]];
    
    AlertWithMessage (message);
}


void AlertWithMessage(NSString *message)
{
    /* open an alert with an OK button */
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"POS", @"Alert title")
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"Alert OK button")
                                          otherButtonTitles: nil];
    [alert show];
}


void AlertWithMessageAndDelegate(NSString *message, id delegate)
{
    /* open an alert with OK and Cancel buttons */
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"POS", @"Alert title")
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", @"Alert Cancel button")
                                          otherButtonTitles:NSLocalizedString(@"OK", @"Alert OK button"), nil];
    [alert show];
}


void HandleErrorAndDisplayToUser(NSError* error, BOOL shouldDisplayToUser)
{
    NSLog(@"%@",[error localizedDescription]);
    
    if (shouldDisplayToUser) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                         message:nil
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"OK", @"Title for cancel button in local notification")
                                               otherButtonTitles:nil];
            [av show];
            av = nil;
        });
    }
}
