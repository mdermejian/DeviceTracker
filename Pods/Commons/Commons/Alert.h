//
//  FSGAlert.h
//  Commons
//
//  Created by Marc Dermejian on 02/02/2015.
//

#import <UIKit/UIKit.h>

void AlertWithError(NSError *error);
void AlertWithMessage(NSString *message);
void AlertWithMessageAndDelegate(NSString *message, id delegate);
void HandleErrorAndDisplayToUser(NSError* error, BOOL shouldDisplayToUser);
