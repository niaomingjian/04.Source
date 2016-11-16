import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule }   from '@angular/forms';
import { RouterModule }   from '@angular/router';

import { HttpModule }    from '@angular/http';

// import { InMemoryWebApiModule } from 'angular-in-memory-web-api';
// import { InMemoryDataService }  from './in-memory-data.service';

import { AppComponent }   from './app.component';
import { HeroesComponent }     from './heroes.component';
import { HeroesComponent_2 }     from './heroes-2.component';
import { HeroDetailComponent } from './hero-detail.component';
import { DashboardComponent } from './dashboard.component';
import { HeroSearchComponent } from './hero-search.component';
import { HeroFormComponent } from './hero-form.component';

import { HeroService } from './hero.service';

import { AppRoutingModule }     from './app-routing.module';

import './rxjs-extensions';

@NgModule({
  imports:      [
    BrowserModule,
    FormsModule,
    HttpModule,
    // InMemoryWebApiModule.forRoot(InMemoryDataService),
    AppRoutingModule
  ],

  declarations: [
    AppComponent,
    HeroesComponent,
    HeroesComponent_2,
    HeroDetailComponent,
    DashboardComponent,
    HeroSearchComponent,
    HeroFormComponent
  ],

  providers: [
    HeroService
  ],
  
  bootstrap:    [ AppComponent ]
})
export class AppModule { }