//
//  AGTWalletTableViewController.m
//  Wallet
//
//  Created by Charles Moncada on 19/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"

static NSString *cellID = @"cellIdentifier";

@interface AGTWalletTableViewController ()

@property(nonatomic, strong) AGTWallet *model;
@property(nonatomic, strong) AGTBroker *broker;

@end

@implementation AGTWalletTableViewController

-(id) initWithModel:(AGTWallet *)model  broker:(AGTBroker *)broker{
    if(self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
        _broker = broker;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Secciones igual a # de currencies +1
    return [self.model numberOfCurrencies] + 1 ;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.model numberOfCurrencies] == section) {
        return 1; //Caso del Gran Total tiene una celda
    }
    
    return [self.model numberOfMoneysForSection:section] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Creamos la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    
    AGTMoney *moneyForCell;
    NSString *textOfCell;
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.maximumFractionDigits = 2;
    nf.minimumFractionDigits = 2;
    nf.minimumIntegerDigits = 1;
    
    //Si la sección es la ultima, mostramos el total de todo el wallet
    if (indexPath.section == [self.model numberOfCurrencies]) {
        moneyForCell = [self.model reduceToCurrency:@"EUR" withBroker:self.broker];
        textOfCell = [NSString stringWithFormat:@"Gran Total: %@ EUR",[nf stringFromNumber:[moneyForCell amount]] ];
    } else {
        //Si la celda es la ultima de la seccion, mostramos el subtotal del currency
        if (indexPath.row == [self.model numberOfMoneysForSection:indexPath.section]) {
            moneyForCell = [self.model getTotalOfCurrency:[[self.model currencies] objectAtIndex: indexPath.section ]];
            textOfCell = [NSString stringWithFormat:@"SubTotal: %@ %@", [nf stringFromNumber:[moneyForCell amount]], [moneyForCell currency]];
        } else {
            //Mostramos el valor de cada money
            moneyForCell = [[self.model moneysForSection:indexPath.section] objectAtIndex:indexPath.row];
            textOfCell = [NSString stringWithFormat:@"%@ %@", [nf stringFromNumber:[moneyForCell amount]], [moneyForCell currency]];
        }
        
    }
    
     //Configure the cell...
    
    cell.textLabel.text = textOfCell;
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section < [self.model numberOfCurrencies]) {
        NSString *sectionText = [NSString stringWithFormat:@"Divisa: %@", [[self.model currencies] objectAtIndex:section] ];
        return sectionText;
    }else{
        return @"Total (EUR)";
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
